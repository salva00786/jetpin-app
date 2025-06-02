// widgets/review_card.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/review.dart'; // Assicurati che sia la versione con airlineIcao
import '../models/reply.dart';
import '../services/review_service.dart';
import '../utils/logo_helper.dart'; // Importa il logo_helper aggiornato
import '../utils/premium_manager.dart';

import 'package:jetpin_app/l10n/app_localizations.dart';
import 'package:jetpin_app/services/profile_actions.dart';


class ReviewCard extends StatefulWidget {
  final Review review;
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;

  const ReviewCard({
    super.key,
    required this.review,
    this.onEditPressed,
    this.onDeletePressed,
  });

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  final ReviewService _reviewService = ReviewService();
  final TextEditingController _replyController = TextEditingController();
  final FocusNode _replyFocusNode = FocusNode();
  final TextEditingController _editReplyController = TextEditingController();

  bool _isRepliesExpanded = false;
  bool _isReplying = false;
  bool _isSendingReply = false;
  bool _isMarkingHelpful = false;

  @override
  void dispose() {
    _replyController.dispose();
    _replyFocusNode.dispose();
    _editReplyController.dispose();
    super.dispose();
  }

  Future<void> _submitReply(S localizations) async {
    // (Codice invariato)
    if (_replyController.text.trim().isEmpty) return;
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null || widget.review.id == null) {
      _showSnackBar(localizations.errorSendingReply, isError: true);
      return;
    }
    setState(() => _isSendingReply = true);
    try {
      await _reviewService.addReply(
        reviewId: widget.review.id!,
        reviewOwnerId: widget.review.userId,
        replyText: _replyController.text.trim(),
        localizations: localizations,
      );
      _replyController.clear();
      setState(() {
        _isReplying = false;
        _isRepliesExpanded = true; 
      });
      if (mounted) _showSnackBar(localizations.replySentSuccessMessage);
    } catch (e) {
      print("Errore invio risposta: $e");
      if (mounted) _showSnackBar(localizations.errorSendingReply, isError: true);
    } finally {
      if (mounted) setState(() => _isSendingReply = false);
    }
  }

  Future<void> _handleMarkAsHelpful() async {
    // (Codice invariato)
    if (widget.review.id == null || _isMarkingHelpful) return;
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null || widget.review.userId == currentUser.uid) {
        return;
    }
    setState(() => _isMarkingHelpful = true);
    try {
      bool success = await _reviewService.incrementHelpfulCount(widget.review.id!);
      if (success && mounted) {
        print("Helpful count incrementato per review ${widget.review.id}");
      }
    } catch (e) {
      print("Errore in _handleMarkAsHelpful: $e");
    } finally {
      if (mounted) setState(() => _isMarkingHelpful = false);
    }
  }

  Future<void> _searchFlightStatus(S localizations) async {
    // (Codice invariato)
    if (widget.review.flightNumber.trim().isEmpty) return;
    final airlineNameForSearch = widget.review.airline.replaceAll(' ', '+');
    final flightNumberForSearch = widget.review.flightNumber.trim().replaceAll(' ', '');
    final url = 'https://www.google.com/search?q=stato+volo+$airlineNameForSearch+$flightNumberForSearch';
    final Uri uri = Uri.parse(url);
    try {
        if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
            throw Exception('Could not launch $url');
        }
    } catch(e) {
         if (mounted) {
            _showSnackBar(localizations.cannotLaunchUrlError(url), isError: true);
        }
    }
  }

  Future<void> _handleEditReply(Reply replyToEdit, S localizations) async {
    // (Codice invariato)
    _editReplyController.text = replyToEdit.replyText;
    final String? newReplyText = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(localizations.editReplyDialogTitle),
          content: TextField(
            controller: _editReplyController,
            autofocus: true,
            decoration: InputDecoration(hintText: localizations.writeReplyHintText),
            maxLines: 3, minLines: 1,
            textCapitalization: TextCapitalization.sentences,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(null),
              child: Text(localizations.cancelButton),
            ),
            ElevatedButton(
              onPressed: () {
                if (_editReplyController.text.trim().isNotEmpty) {
                  Navigator.of(dialogContext).pop(_editReplyController.text.trim());
                }
              },
              child: Text(localizations.updateReplyButtonLabel),
            ),
          ],
        );
      },
    );

    if (newReplyText != null && newReplyText.isNotEmpty) {
      showLoadingDialog(context, localizations.loadingText);
      final success = await _reviewService.updateReply(
        reviewId: replyToEdit.reviewId,
        replyId: replyToEdit.id!,
        newReplyText: newReplyText,
      );
      if (mounted) closeLoadingDialog(context);
      
      if (mounted) {
        if (success) {
          _showSnackBar(localizations.replyUpdatedSuccessMessage);
        } else {
          _showSnackBar(localizations.errorUpdatingReply, isError: true);
        }
      }
    }
     _editReplyController.clear();
  }

  Future<void> _handleDeleteReply(Reply replyToDelete, S localizations) async {
    // (Codice invariato)
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(localizations.deleteReplyConfirmTitle),
          content: Text(localizations.deleteReplyConfirmMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(localizations.cancelButton),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(localizations.deleteButton),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      showLoadingDialog(context, localizations.loadingText);
      final success = await _reviewService.deleteReply(
        reviewId: replyToDelete.reviewId,
        replyId: replyToDelete.id!,
      );
      if (mounted) closeLoadingDialog(context);

      if (mounted) {
        if (success) {
          _showSnackBar(localizations.replyDeletedSuccessMessage);
        } else {
          _showSnackBar(localizations.errorDeletingReply, isError: true);
        }
      }
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    // (Codice invariato)
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: isError ? Theme.of(context).colorScheme.error : null,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final S localizations = S.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final currentUser = FirebaseAuth.instance.currentUser;

    final String formattedDate = DateFormat('dd MMM yy – HH:mm', locale).format(widget.review.date.toLocal());
    String? formattedLastEditedDate;
    if (widget.review.lastEditedAt != null) {
      formattedLastEditedDate = DateFormat('dd MMM yy – HH:mm', locale).format(widget.review.lastEditedAt!.toLocal());
    }
    
    // --- LOGICA LOGO AGGIORNATA ---
    String logoPath = '';
    if (widget.review.airlineIcao != null && widget.review.airlineIcao!.isNotEmpty) {
      logoPath = getLogoPathByIcao(widget.review.airlineIcao);
    }
    // Fallback se airlineIcao non c'è o getLogoPathByIcao non trova nulla (improbabile se ICAO è valido)
    if (logoPath.isEmpty) {
      logoPath = getLogoPathByName(widget.review.airline);
    }
    // --- FINE LOGICA LOGO AGGIORNATA ---


    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: logoPath.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          child: Image.asset(
                            logoPath, // Usa il percorso aggiornato .webp
                            width: 36, height: 36, fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              print("Errore caricamento logo $logoPath: $error");
                              return const Icon(Icons.flight_takeoff_outlined, size: 36, color: Colors.grey);
                            }
                          ),
                        )
                      : const Icon(Icons.flight_takeoff_outlined, size: 36, color: Colors.grey),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.review.airline} • ${widget.review.flightNumber}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (widget.review.flightNumber.trim().isNotEmpty)
                        FutureBuilder<bool>(
                          future: PremiumManager.isPremium(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done && snapshot.data == true) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: InkWell(
                                  onTap: () => _searchFlightStatus(localizations),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.travel_explore, size: 14, color: Theme.of(context).colorScheme.secondary),
                                      const SizedBox(width: 4.0),
                                      Text(
                                        localizations.searchFlightStatusButtonLabel,
                                        style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.secondary),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            RatingBarIndicator(
              rating: widget.review.rating.toDouble(),
              itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
              itemCount: 5, itemSize: 20.0, direction: Axis.horizontal,
            ),
            if (widget.review.comment.isNotEmpty) ...[
              const SizedBox(height: 10.0),
              Text(widget.review.comment, style: Theme.of(context).textTheme.bodyMedium),
            ],
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '🧑 ${widget.review.userName} – $formattedDate',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade700),
                      ),
                      if (formattedLastEditedDate != null) ...[
                        const SizedBox(height: 2.0),
                        Text(
                          localizations.reviewCardEditedOn(formattedLastEditedDate),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600, fontStyle: FontStyle.italic, fontSize: 11),
                        ),
                      ]
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.onEditPressed != null)
                      IconButton(
                        icon: Icon(Icons.edit_note_outlined, color: Theme.of(context).colorScheme.primary),
                        tooltip: localizations.editReviewButtonLabel,
                        onPressed: widget.onEditPressed,
                        iconSize: 20.0, padding: const EdgeInsets.all(4.0), constraints: const BoxConstraints(),
                      ),
                    if (widget.onDeletePressed != null)
                      IconButton(
                        icon: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.error),
                        tooltip: localizations.deleteReviewButtonLabel,
                        onPressed: widget.onDeletePressed,
                        iconSize: 20.0, padding: const EdgeInsets.all(4.0), constraints: const BoxConstraints(),
                      ),
                  ],
                ),
              ],
            ),
            const Divider(height: 16.0, thickness: 0.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.thumb_up_outlined, color: Theme.of(context).colorScheme.onSurfaceVariant, size: 18.0),
                      tooltip: localizations.markAsHelpfulButtonTooltip,
                      onPressed: (currentUser == null || _isMarkingHelpful || (currentUser != null && widget.review.userId == currentUser.uid))
                          ? null
                          : _handleMarkAsHelpful,
                      padding: const EdgeInsets.all(4.0), constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      '${widget.review.helpfulCount}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
                const Spacer(),
                StreamBuilder<List<Reply>>(
                  stream: widget.review.id != null ? _reviewService.getRepliesForReview(widget.review.id!) : Stream.value([]),
                  builder: (context, snapshot) {
                    final int replyCount = snapshot.data?.length ?? 0;
                    String replyButtonText;
                    if (!_isRepliesExpanded) {
                        if (replyCount == 0) replyButtonText = localizations.viewRepliesButtonLabel_zero;
                        else if (replyCount == 1) replyButtonText = localizations.viewRepliesButtonLabel_one;
                        else replyButtonText = localizations.viewRepliesButtonLabel_other(replyCount);
                    } else {
                        replyButtonText = localizations.hideRepliesButtonLabel;
                    }
                    return TextButton(
                      child: Text(replyButtonText, style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.primary)),
                      onPressed: (replyCount > 0 || _isRepliesExpanded) && widget.review.id != null
                          ? () => setState(() => _isRepliesExpanded = !_isRepliesExpanded)
                          : null,
                    );
                  }
                ),
                if (currentUser != null && widget.review.id != null)
                  TextButton(
                    child: Text(localizations.replyButtonLabel, style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.primary)),
                    onPressed: () {
                      setState(() => _isReplying = !_isReplying);
                       if (_isReplying) {
                         WidgetsBinding.instance.addPostFrameCallback((_) {
                           if(mounted) _replyFocusNode.requestFocus();
                         });
                       } else {
                          _replyFocusNode.unfocus();
                       }
                    },
                  ),
              ],
            ),
            if (_isRepliesExpanded && widget.review.id != null)
              StreamBuilder<List<Reply>>(
                stream: _reviewService.getRepliesForReview(widget.review.id!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting && !(snapshot.hasData && snapshot.data!.isNotEmpty)) {
                    return const Padding(padding: EdgeInsets.only(top: 8.0), child: Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))));
                  }
                  if (snapshot.hasError) {
                    return Padding(padding: const EdgeInsets.only(top: 8.0), child: Text(localizations.errorLoadingData, style: TextStyle(color: Theme.of(context).colorScheme.error)));
                  }
                  final replies = snapshot.data ?? [];
                  if (replies.isEmpty && _isRepliesExpanded) {
                    return Padding(
                      padding: const EdgeInsets.only(top:8.0, left: 8.0),
                      child: Text(localizations.noRepliesYet, style: Theme.of(context).textTheme.bodySmall)
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: replies.map((reply) => _ReplyItem(
                        reply: reply,
                        onEditReply: (currentUser != null && currentUser.uid == reply.replierId)
                                      ? () => _handleEditReply(reply, localizations)
                                      : null,
                        onDeleteReply: (currentUser != null && (currentUser.uid == reply.replierId || currentUser.uid == widget.review.userId))
                                      ? () => _handleDeleteReply(reply, localizations)
                                      : null,
                      )).toList(),
                    ),
                  );
                },
              ),
            if (_isReplying && currentUser != null && widget.review.id != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextField(
                        controller: _replyController,
                        focusNode: _replyFocusNode,
                        decoration: InputDecoration(
                          hintText: localizations.writeReplyHintText,
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                        ),
                        textCapitalization: TextCapitalization.sentences,
                        maxLines: 3, minLines: 1,
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                           TextButton(
                            child: Text(localizations.cancelButton),
                            onPressed: _isSendingReply ? null : () {
                              setState(() {
                                _isReplying = false;
                                _replyController.clear();
                                _replyFocusNode.unfocus();
                              });
                            },
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: _isSendingReply || _replyController.text.trim().isEmpty
                                ? null
                                : () => _submitReply(localizations),
                            child: _isSendingReply
                                ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                : Text(localizations.sendReplyButtonLabel),
                          ),
                        ],
                      ),
                    ],
                  ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ReplyItem extends StatelessWidget {
  // (Codice _ReplyItem invariato, ma assicurati che usi localizations passate o S.of(context)!)
  final Reply reply;
  final VoidCallback? onEditReply;
  final VoidCallback? onDeleteReply;

  const _ReplyItem({
    required this.reply,
    this.onEditReply,
    this.onDeleteReply,
  });

  @override
  Widget build(BuildContext context) {
    final S localizations = S.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final String formattedTimestamp = DateFormat('dd MMM yy, HH:mm', locale).format(reply.timestamp.toLocal());
    String? formattedLastEditedReplyDate;
    if (reply.lastEditedAt != null) {
      formattedLastEditedReplyDate = DateFormat('dd MMM yy, HH:mm', locale).format(reply.lastEditedAt!.toLocal());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(
                        children: [
                          Text(
                            reply.replierName,
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 6.0),
                          Text(
                            formattedTimestamp,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600, fontSize: 11),
                          ),
                        ],
                      ),
                      if (formattedLastEditedReplyDate != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text(
                            localizations.replyCardEditedOn(formattedLastEditedReplyDate),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600, fontStyle: FontStyle.italic, fontSize: 10),
                          ),
                        ),
                  ],
                ),
              ),
              if (onEditReply != null || onDeleteReply != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (onEditReply != null)
                      IconButton(
                        icon: Icon(Icons.edit_note_outlined, size: 18, color: Theme.of(context).colorScheme.onSurfaceVariant),
                        tooltip: localizations.editReplyButtonTooltip,
                        onPressed: onEditReply,
                        padding: const EdgeInsets.all(2.0),
                        constraints: const BoxConstraints(),
                      ),
                    if (onDeleteReply != null)
                      IconButton(
                        icon: Icon(Icons.delete_outline, size: 18, color: Theme.of(context).colorScheme.error),
                        tooltip: localizations.deleteReplyButtonTooltip,
                        onPressed: onDeleteReply,
                        padding: const EdgeInsets.all(2.0),
                        constraints: const BoxConstraints(),
                      ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 2.0),
          Text(reply.replyText, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
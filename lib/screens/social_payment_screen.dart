import 'package:flutter/material.dart';
import '../models/social_payment.dart';
import '../services/social_payment_service.dart';

class SocialPaymentScreen extends StatefulWidget {
  const SocialPaymentScreen({super.key});

  @override
  State<SocialPaymentScreen> createState() => _SocialPaymentScreenState();
}

class _SocialPaymentScreenState extends State<SocialPaymentScreen>
    with SingleTickerProviderStateMixin {
  final SocialPaymentService _socialPaymentService = SocialPaymentService();
  late Future<List<SocialPayment>> _paymentsFuture;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _paymentsFuture = _socialPaymentService.getSocialPayments();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Social Payments',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Active', icon: Icon(Icons.pending_actions)),
            Tab(text: 'History', icon: Icon(Icons.history)),
            Tab(text: 'Social Feed', icon: Icon(Icons.people)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              _showCreatePaymentDialog(context);
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildActivePaymentsTab(),
          _buildPaymentHistoryTab(),
          _buildSocialFeedTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showSendGiftDialog(context);
        },
        icon: const Icon(Icons.card_giftcard),
        label: const Text('Send Gift'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  Widget _buildActivePaymentsTab() {
    return FutureBuilder<List<SocialPayment>>(
      future: _paymentsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.group_outlined, size: 80, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No active payments',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                SizedBox(height: 8),
                Text(
                  'Create a new payment to split with friends',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        } else {
          final payments =
              snapshot.data!.where((p) => p.status == 'pending').toList();
          if (payments.isEmpty) {
            return const Center(child: Text('No active payments'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: payments.length,
            itemBuilder: (context, index) {
              final payment = payments[index];
              return _buildPaymentCard(payment, isActive: true);
            },
          );
        }
      },
    );
  }

  Widget _buildPaymentHistoryTab() {
    return FutureBuilder<List<SocialPayment>>(
      future: _paymentsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No payment history'));
        } else {
          final payments =
              snapshot.data!.where((p) => p.status == 'completed').toList();
          if (payments.isEmpty) {
            return const Center(child: Text('No completed payments'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: payments.length,
            itemBuilder: (context, index) {
              final payment = payments[index];
              return _buildPaymentCard(payment, isActive: false);
            },
          );
        }
      },
    );
  }

  Widget _buildSocialFeedTab() {
    return FutureBuilder<List<SocialPayment>>(
      future: _paymentsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No social activity'));
        } else {
          // Sort by date, newest first
          final payments =
              snapshot.data!..sort((a, b) => b.date.compareTo(a.date));
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: payments.length,
            itemBuilder: (context, index) {
              final payment = payments[index];
              return _buildSocialFeedCard(payment);
            },
          );
        }
      },
    );
  }

  Widget _buildPaymentCard(SocialPayment payment, {required bool isActive}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    payment.description,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${payment.amount} ${payment.currency}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Created by ${payment.senderName}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Date: ${payment.date.day}/${payment.date.month}/${payment.date.year}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            const Text(
              'Participants:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...payment.participants.map(
              (participant) => _buildParticipantItem(participant, isActive),
            ),
            if (isActive &&
                payment.message != null &&
                payment.message!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.message, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        payment.message!,
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (isActive) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total paid: ${payment.totalPaid} / ${payment.amount} ${payment.currency}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (payment.isSettled)
                    const Chip(
                      label: Text('Fully Settled'),
                      backgroundColor: Colors.green,
                      labelStyle: TextStyle(color: Colors.white),
                    )
                  else
                    OutlinedButton(
                      onPressed: () {
                        // Show payment options
                      },
                      child: const Text('Pay Now'),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildParticipantItem(Participant participant, bool isActive) {
    Color statusColor;
    IconData statusIcon;

    switch (participant.status.toLowerCase()) {
      case 'paid':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'pending':
        statusColor = Colors.orange;
        statusIcon = Icons.pending;
        break;
      case 'declined':
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.help;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(statusIcon, color: statusColor, size: 16),
          const SizedBox(width: 8),
          Expanded(child: Text(participant.name)),
          Text(
            '${participant.amountPaid} / ${participant.amountOwed} ${isActive ? '' : 'paid'}',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: participant.hasPaid ? Colors.green : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialFeedCard(SocialPayment payment) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with user info
          ListTile(
            leading: CircleAvatar(child: Text(payment.senderName[0])),
            title: Text(payment.senderName),
            subtitle: Text(
              '${payment.date.day}/${payment.date.month}/${payment.date.year}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            trailing: Icon(
              payment.status == 'completed'
                  ? Icons.check_circle
                  : Icons.pending,
              color:
                  payment.status == 'completed' ? Colors.green : Colors.orange,
            ),
          ),
          // Payment image if available
          if (payment.imageUrl != null && payment.imageUrl!.isNotEmpty)
            Image.network(
              payment.imageUrl!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 100,
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(Icons.image_not_supported, size: 40),
                  ),
                );
              },
            ),
          // Payment details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  payment.description,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${payment.amount} ${payment.currency}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (payment.message != null && payment.message!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '"${payment.message!}"',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Text(
                  'With ${payment.participants.map((p) => p.name).join(', ')}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 16),
                // Social actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSocialAction(Icons.thumb_up_outlined, 'Like'),
                    _buildSocialAction(Icons.comment_outlined, 'Comment'),
                    _buildSocialAction(Icons.share_outlined, 'Share'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialAction(IconData icon, String label) {
    return InkWell(
      onTap: () {
        // Handle social action
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.grey[700]),
            const SizedBox(width: 4),
            Text(label, style: TextStyle(color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }

  void _showCreatePaymentDialog(BuildContext context) {
    final descriptionController = TextEditingController();
    final amountController = TextEditingController();
    final messageController = TextEditingController();
    String currency = 'USD';
    final participants = <Map<String, dynamic>>[
      {'name': '', 'email': '', 'amount': ''},
    ];

    showDialog(
      context: context,
      builder:
          (ctx) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('Split a Bill'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          hintText: 'e.g., Dinner at Restaurant',
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextField(
                              controller: amountController,
                              decoration: const InputDecoration(
                                labelText: 'Total Amount',
                                hintText: 'e.g., 120',
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 1,
                            child: DropdownButtonFormField<String>(
                              value: currency,
                              decoration: const InputDecoration(
                                labelText: 'Currency',
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 'USD',
                                  child: Text('USD'),
                                ),
                                DropdownMenuItem(
                                  value: 'EUR',
                                  child: Text('EUR'),
                                ),
                                DropdownMenuItem(
                                  value: 'GBP',
                                  child: Text('GBP'),
                                ),
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  currency = value;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: messageController,
                        decoration: const InputDecoration(
                          labelText: 'Message (Optional)',
                          hintText: 'e.g., Thanks for joining!',
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Participants',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ...List.generate(
                        participants.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: TextField(
                                  decoration: const InputDecoration(
                                    labelText: 'Name',
                                    hintText: 'e.g., John',
                                  ),
                                  onChanged: (value) {
                                    participants[index]['name'] = value;
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 2,
                                child: TextField(
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                    hintText: 'e.g., john@example.com',
                                  ),
                                  onChanged: (value) {
                                    participants[index]['email'] = value;
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  decoration: const InputDecoration(
                                    labelText: 'Amount',
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    participants[index]['amount'] = value;
                                  },
                                ),
                              ),
                              if (index > 0)
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      participants.removeAt(index);
                                    });
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                      TextButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text('Add Participant'),
                        onPressed: () {
                          setState(() {
                            participants.add({
                              'name': '',
                              'email': '',
                              'amount': '',
                            });
                          });
                        },
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Validate inputs
                      if (descriptionController.text.isEmpty ||
                          amountController.text.isEmpty ||
                          participants.any(
                            (p) =>
                                p['name'].isEmpty ||
                                p['email'].isEmpty ||
                                p['amount'].isEmpty,
                          )) {
                        return;
                      }

                      // Create payment
                      final totalAmount = double.parse(amountController.text);
                      final participantsList =
                          participants
                              .map(
                                (p) => Participant(
                                  id:
                                      'user${DateTime.now().millisecondsSinceEpoch}${participants.indexOf(p)}',
                                  name: p['name'],
                                  email: p['email'],
                                  amountOwed: double.parse(p['amount']),
                                  amountPaid: 0.0,
                                  status: 'pending',
                                ),
                              )
                              .toList();

                      final payment = SocialPayment(
                        id: 'sp${DateTime.now().millisecondsSinceEpoch}',
                        amount: totalAmount,
                        currency: currency,
                        senderId: 'currentUser',
                        senderName: 'Current User',
                        participants: participantsList,
                        description: descriptionController.text,
                        date: DateTime.now(),
                        status: 'pending',
                        message:
                            messageController.text.isEmpty
                                ? null
                                : messageController.text,
                      );

                      _socialPaymentService.createSocialPayment(payment).then((
                        _,
                      ) {
                        setState(() {
                          _paymentsFuture =
                              _socialPaymentService.getSocialPayments();
                        });
                        Navigator.of(ctx).pop();
                      });
                    },
                    child: const Text('Create'),
                  ),
                ],
              );
            },
          ),
    );
  }

  void _showSendGiftDialog(BuildContext context) {
    final recipientNameController = TextEditingController();
    final recipientEmailController = TextEditingController();
    final amountController = TextEditingController();
    final messageController = TextEditingController();
    String currency = 'USD';

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Send a Gift'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: recipientNameController,
                    decoration: const InputDecoration(
                      labelText: 'Recipient Name',
                      hintText: 'e.g., Sarah',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: recipientEmailController,
                    decoration: const InputDecoration(
                      labelText: 'Recipient Email',
                      hintText: 'e.g., sarah@example.com',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: amountController,
                          decoration: const InputDecoration(
                            labelText: 'Amount',
                            hintText: 'e.g., 50',
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: DropdownButtonFormField<String>(
                          value: currency,
                          decoration: const InputDecoration(
                            labelText: 'Currency',
                          ),
                          items: const [
                            DropdownMenuItem(value: 'USD', child: Text('USD')),
                            DropdownMenuItem(value: 'EUR', child: Text('EUR')),
                            DropdownMenuItem(value: 'GBP', child: Text('GBP')),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              currency = value;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      labelText: 'Personal Message',
                      hintText: 'e.g., Happy Birthday!',
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Validate inputs
                  if (recipientNameController.text.isEmpty ||
                      recipientEmailController.text.isEmpty ||
                      amountController.text.isEmpty ||
                      messageController.text.isEmpty) {
                    return;
                  }

                  // Send gift payment
                  _socialPaymentService
                      .sendGiftPayment(
                        amount: double.parse(amountController.text),
                        currency: currency,
                        recipientId:
                            'recipient${DateTime.now().millisecondsSinceEpoch}',
                        recipientName: recipientNameController.text,
                        recipientEmail: recipientEmailController.text,
                        message: messageController.text,
                      )
                      .then((_) {
                        setState(() {
                          _paymentsFuture =
                              _socialPaymentService.getSocialPayments();
                        });
                        Navigator.of(ctx).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Gift sent successfully!'),
                          ),
                        );
                      });
                },
                child: const Text('Send Gift'),
              ),
            ],
          ),
    );
  }
}

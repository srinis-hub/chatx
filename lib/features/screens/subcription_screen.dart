import 'package:flutter/material.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  static const Color premiumColor = Color(0xFF6C63FF);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("ChatX Premium"), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Premium Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    colors: [Color(0xff7B61FF), Color(0xff5D5FEF)],
                  ),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.workspace_premium_rounded,
                      size: 70,
                      color: Colors.white,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Unlock ChatX Premium",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Personalize your AI assistant and enjoy premium features.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontSize: 15),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              _featureTile(
                Icons.psychology_alt_outlined,
                "Custom AI Behavior",
                "Create your own AI personality and system prompt.",
              ),

              _featureTile(
                Icons.auto_awesome_outlined,
                "Priority Features",
                "Get early access to upcoming premium features.",
              ),

              _featureTile(
                Icons.speed_outlined,
                "Better Experience",
                "Enjoy a cleaner and enhanced ChatX experience.",
              ),

              _featureTile(
                Icons.update_outlined,
                "Lifetime Updates",
                "Receive all future premium improvements.",
              ),

              const SizedBox(height: 25),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: theme.colorScheme.primaryContainer,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text(
                        "ONE-TIME PURCHASE",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "₹299",
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Pay once. Use forever.",
                      style: TextStyle(fontSize: 16,color: Colors.white),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton.icon(
                  onPressed: () {
                    // TODO: Razorpay / Play Billing
                  },
                  icon: const Icon(Icons.lock_open),
                  label: const Text(
                    "Unlock Premium",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              TextButton(
                onPressed: () {
                  // TODO: Restore Purchases
                },
                child: const Text("Restore Purchases"),
              ),

              const SizedBox(height: 20),

              Text(
                "Payment is processed securely.\nPremium is linked to your ChatX account.",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _featureTile(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Card(
        elevation: 0,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: premiumColor.withValues(alpha: 0.12),
            child: Icon(icon, color: premiumColor),
          ),
          title: Text(title),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }
}

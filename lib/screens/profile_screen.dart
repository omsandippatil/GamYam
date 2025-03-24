import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/floating_navbar.dart'; 

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          // Custom App Bar with gradient
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF3D405B),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'Profile',
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF3D405B), Color(0xFF2D3142)],
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_outlined, color: Colors.white),
                onPressed: () {
                  // Navigate to settings
                },
              ),
            ],
          ),
          
          // Profile Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Avatar and Name Section with elevation effect
                  Center(
                    child: Column(
                      children: [
                        // Avatar with border and shadow
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                spreadRadius: 2,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: const BoxDecoration(
                              color: Color(0xFF3D405B),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage('https://media.licdn.com/dms/image/v2/D4E03AQFrmDuWUxQoMg/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1715645354619?e=2147483647&v=beta&t=dkLl7DSveuVd5sakuJ-nk0akumosrA4bx8UCOytIsh0'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Name with larger text
                        Text(
                          'Sundar Pichai',
                          style: GoogleFonts.outfit(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF2D3142),
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Email with improved styling
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.email_outlined,
                              size: 16,
                              color: Color(0xFF3D405B),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'sundar@google.com',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF3D405B).withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                  
                  // Enhanced Stats Card
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF3D405B), Color(0xFF2D3142)],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF3D405B).withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildEnhancedStatItem(
                          context,
                          'Level',
                          '12',
                          Icons.trending_up_rounded,
                        ),
                        _buildVerticalDivider(),
                        _buildEnhancedStatItem(
                          context,
                          'Streaks',
                          '8',
                          Icons.local_fire_department_rounded,
                          suffix: 'days',
                        ),
                        _buildVerticalDivider(),
                        _buildEnhancedStatItem(
                          context,
                          'Aura Points',
                          '2,450',
                          Icons.stars_rounded,
                        ),
                      ],
                    ),
                  ),
                  
                  // Leaderboard Preview Card
                  _buildLeaderboardPreview(context),
                  
                  const SizedBox(height: 30),
                  
                  // Section Title with improved styling
                  _buildSectionTitle('Account Settings'),
                  
                  const SizedBox(height: 16),
                  
                  // Settings List with enhanced styling
                  _buildSettingsItem(
                    icon: Icons.person_outline,
                    title: 'Personal Information',
                    subtitle: 'Update your personal details',
                    color: const Color(0xFF3D405B),
                  ),
                  _buildSettingsItem(
                    icon: Icons.notifications_none_rounded,
                    title: 'Notifications',
                    subtitle: 'Manage your notification preferences',
                    color: const Color(0xFFFF6B6B),
                  ),
                  _buildSettingsItem(
                    icon: Icons.lock_outline_rounded,
                    title: 'Privacy & Security',
                    subtitle: 'Control your privacy settings',
                    color: const Color(0xFF2ECC71),
                  ),
                  _buildSettingsItem(
                    icon: Icons.bar_chart_rounded,
                    title: 'Goals & Progress',
                    subtitle: 'View and update your goals',
                    color: const Color(0xFFFFD166),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Section Title
                  _buildSectionTitle('Help & Support'),
                  
                  const SizedBox(height: 16),
                  
                  // Help Items with improved styling
                  _buildSettingsItem(
                    icon: Icons.help_outline_rounded,
                    title: 'FAQs',
                    subtitle: 'Find answers to common questions',
                    color: const Color(0xFF9B59B6),
                  ),
                  _buildSettingsItem(
                    icon: Icons.email_outlined,
                    title: 'Contact Support',
                    subtitle: 'Get help from our support team',
                    color: const Color(0xFF3498DB),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Improved Logout Button
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF6B6B), Color(0xFFFF8E8E)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF6B6B).withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {
                          // Add logout functionality
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.logout_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Logout',
                              style: GoogleFonts.outfit(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const FloatingNavbar(),
    );
  }

  // Enhanced stat item with icons
  Widget _buildEnhancedStatItem(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    String suffix = '',
  }) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white.withOpacity(0.9),
              size: 20,
            ),
            const SizedBox(width: 6),
            Text(
              value,
              style: GoogleFonts.outfit(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            if (suffix.isNotEmpty)
              Text(
                ' $suffix',
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  // Vertical divider for stat items
  Widget _buildVerticalDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.white.withOpacity(0.2),
    );
  }

  // Section title with improved styling
  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: const Color(0xFF3D405B),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF2D3142),
          ),
        ),
      ],
    );
  }

  // Enhanced settings item with animation
  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            // Navigate to respective setting screen
          },
          splashColor: color.withOpacity(0.1),
          highlightColor: color.withOpacity(0.05),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2D3142),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF2D3142),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Leaderboard preview card with navigation to full leaderboard
  Widget _buildLeaderboardPreview(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with view all button
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.emoji_events_rounded,
                      color: Color(0xFFFFD166),
                      size: 28,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Leaderboard',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2D3142),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    // Navigate to the full leaderboard screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LeaderboardScreen(),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'View All',
                          style: GoogleFonts.outfit(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF3D405B),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: Color(0xFF3D405B),
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Leaderboard entries
          _buildLeaderboardEntry(
            rank: 1,
            name: 'Prabhakar Raghavan',
            points: 3240,
            avatarUrl: 'https://images.indianexpress.com/2024/10/Untitled-design-26-1.jpg',
            isCurrentUser: false,
          ),
          _buildLeaderboardEntry(
            rank: 2,
            name: 'Sundar Pichai',
            points: 2450,
            avatarUrl: 'https://media.licdn.com/dms/image/v2/D4E03AQFrmDuWUxQoMg/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1715645354619?e=2147483647&v=beta&t=dkLl7DSveuVd5sakuJ-nk0akumosrA4bx8UCOytIsh0',
            isCurrentUser: true,
          ),
          _buildLeaderboardEntry(
            rank: 3,
            name: 'Preeti Lobana',
            points: 2110,
            avatarUrl: 'https://exchange4media.gumlet.io/news-photo/139487-googoo.jpg',
            isCurrentUser: false,
          ),
          
          // See more button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: TextButton(
              onPressed: () {
                // Navigate to the full leaderboard screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LeaderboardScreen(),
                  ),
                );
              },
              child: Text(
                'See Full Leaderboard',
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF3D405B),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Individual leaderboard entry
  Widget _buildLeaderboardEntry({
    required int rank,
    required String name,
    required int points,
    required String avatarUrl,
    required bool isCurrentUser,
  }) {
    // Colors for different ranks
    final rankColors = {
      1: const Color(0xFFFFD700), // Gold
      2: const Color(0xFFC0C0C0), // Silver
      3: const Color(0xFFCD7F32), // Bronze
    };
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isCurrentUser ? const Color(0xFFF0F7FF) : Colors.transparent,
        border: isCurrentUser
            ? Border.all(color: const Color(0xFF3D405B).withOpacity(0.1))
            : null,
        borderRadius: isCurrentUser ? BorderRadius.circular(12) : null,
      ),
      margin: isCurrentUser
          ? const EdgeInsets.symmetric(horizontal: 12, vertical: 4)
          : EdgeInsets.zero,
      child: Row(
        children: [
          // Rank
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: rankColors[rank] ?? const Color(0xFF3D405B).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                rank.toString(),
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: rankColors.containsKey(rank)
                      ? Colors.black.withOpacity(0.7)
                      : const Color(0xFF3D405B),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          
          // Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(avatarUrl),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          
          // Name
          Expanded(
            child: Text(
              name,
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: isCurrentUser ? FontWeight.w700 : FontWeight.w600,
                color: const Color(0xFF2D3142),
              ),
            ),
          ),
          
          // Points
          Row(
            children: [
              const Icon(
                Icons.stars_rounded,
                color: Color(0xFFFFD166),
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                points.toString(),
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF3D405B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Create a LeaderboardScreen class that will be navigated to
class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3D405B),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Leaderboard',
          style: GoogleFonts.outfit(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {
              // Show filter options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Top users section with podium
          Container(
            padding: const EdgeInsets.only(top: 30, bottom: 40),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF3D405B), Color(0xFF2D3142)],
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Top Players',
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // 2nd Place
                    _buildPodiumUser(
                      context,
                      name: 'Sundar ',
                      points: 2950,
                      rank: 2,
                      height: 90,
                    ),
                    
                    const SizedBox(width: 16),
                    
                    // 1st Place
                    _buildPodiumUser(
                      context,
                      name: 'Prabhakar',
                      points: 3240,
                      rank: 1,
                      height: 110,
                    ),
                    
                    const SizedBox(width: 16),
                    
                    // 3rd Place
                    _buildPodiumUser(
                      context,
                      name: 'Preeti',
                      points: 2110,
                      rank: 3,
                      height: 70,
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Tab bar for different timeframes
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: DefaultTabController(
              length: 3,
              child: TabBar(
                labelColor: const Color(0xFF3D405B),
                unselectedLabelColor: Colors.grey.shade600,
                indicatorColor: const Color(0xFF3D405B),
                indicatorWeight: 3,
                labelStyle: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                tabs: const [
                  Tab(text: 'Weekly'),
                  Tab(text: 'Monthly'),
                  Tab(text: 'All Time'),
                ],
              ),
            ),
          ),
          
          // Leaderboard list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              itemCount: 20, // Example count
              itemBuilder: (context, index) {
                final rank = index + 1;
                final isCurrentUser = rank == 5; // Example: current user is 5th
                
                return _buildLeaderboardListItem(
                  rank: rank,
                  name: rank == 2 ? 'Sundar Pichai' : 'User ${rank + 100}',
                  points: 4000 - (rank * 100),
                  avatarUrl: 'https://media.licdn.com/dms/image/v2/D4E03AQFrmDuWUxQoMg/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1715645354619?e=2147483647&v=beta&t=dkLl7DSveuVd5sakuJ-nk0akumosrA4bx8UCOytIsh0',
                  isCurrentUser: isCurrentUser,
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const FloatingNavbar(),
    );
  }

  // Podium user widget for top 3
  Widget _buildPodiumUser(
    BuildContext context, {
    required String name,
    required int points,
    required int rank,
    required double height,
  }) {
    // Colors for different ranks
    final rankColors = {
      1: const Color(0xFFFFD700), // Gold
      2: const Color(0xFFC0C0C0), // Silver
      3: const Color(0xFFCD7F32), // Bronze
    };
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Avatar with crown for 1st place
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: rank == 1 ? 80 : 70,
              height: rank == 1 ? 80 : 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: rankColors[rank] ?? Colors.white,
                  width: 3,
                ),
                image: const DecorationImage(
                  image: NetworkImage('https://via.placeholder.com/80'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
            
            // Crown for 1st place
            if (rank == 1)
              Positioned(
                top: -20,
                left: 0,
                right: 0,
                child: Icon(
                  Icons.emoji_events,
                  color: rankColors[1],
                  size: 36,
                ),
              ),
            
            // Rank indicator
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: rankColors[rank],
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Center(
                  child: Text(
                    rank.toString(),
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 10),
        
        // Name
        Text(
          name,
          style: GoogleFonts.outfit(
            fontSize: rank == 1 ? 16 : 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        
        const SizedBox(height: 4),
        
        // Points
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: rankColors[rank]?.withOpacity(0.3) ?? Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.stars_rounded,
                color: Colors.white,
                size: 14,
              ),
              const SizedBox(width: 4),
              Text(
                points.toString(),
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 10),
        
        // Podium
        Container(
          width: rank == 1 ? 80 : 60,
          height: height,
          decoration: BoxDecoration(
            color: rankColors[rank]?.withOpacity(0.8) ?? Colors.white.withOpacity(0.1),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Center(
            child: Text(
              // Center text showing the rank number
              rank.toString(),
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Individual leaderboard list item
  Widget _buildLeaderboardListItem({
    required int rank,
    required String name,
    required int points,
    required String avatarUrl,
    required bool isCurrentUser,
  }) {
    // Colors for different ranks
    final rankColors = {
      1: const Color(0xFFFFD700), // Gold
      2: const Color(0xFFC0C0C0), // Silver
      3: const Color(0xFFCD7F32), // Bronze
    };
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isCurrentUser ? const Color(0xFFF0F7FF) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isCurrentUser
            ? Border.all(color: const Color(0xFF3D405B).withOpacity(0.2))
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Rank
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: rankColors[rank] ?? const Color(0xFF3D405B).withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: rankColors[rank] != null
                    ? Colors.white
                    : Colors.transparent,
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                rank.toString(),
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: rankColors.containsKey(rank)
                      ? Colors.black.withOpacity(0.7)
                      : const Color(0xFF3D405B),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // Avatar
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(avatarUrl),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: isCurrentUser ? const Color(0xFF3D405B) : Colors.white,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          
          // Name and level
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: isCurrentUser ? FontWeight.w700 : FontWeight.w600,
                    color: const Color(0xFF2D3142),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3D405B).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.trending_up_rounded,
                            color: Color(0xFF3D405B),
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Level ${20 - (rank ~/ 2)}',
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF3D405B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isCurrentUser)
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3D405B),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'You',
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          
          // Points
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFFFFD166).withOpacity(0.5),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.stars_rounded,
                  color: Color(0xFFFFD166),
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(
                  points.toString(),
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF3D405B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
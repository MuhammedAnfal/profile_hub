// user_details_page.dart
import 'package:flutter/material.dart';
import 'package:profile_hub/core/utils/extension/size_extension/size_extension.dart';
import 'package:profile_hub/core/utils/palette/palette.dart';
import 'package:profile_hub/models/user_model.dart';

class UserDetailsPage extends StatelessWidget {
  final UserModel user;

  const UserDetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _UserDetailsContent(user: user),
    );
  }
}

class _UserDetailsContent extends StatelessWidget {
  final UserModel user;

  const _UserDetailsContent({required this.user});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //-- Static background - no animations
        const _Background(),

        CustomScrollView(
          physics: const BouncingScrollPhysics(),
          cacheExtent: 1000,
          slivers: [
            _AppBarSection(user: user),
            _ContentSection(user: user),
          ],
        ),
      ],
    );
  }
}

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.fromARGB(255, 53, 15, 99), Palette.blackColor], // Pre-defined colors
        ),
      ),
    );
  }
}

class _AppBarSection extends StatelessWidget {
  final UserModel user;

  const _AppBarSection({required this.user});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      collapsedHeight: 100,
      floating: true,
      pinned: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: _BackButton(),
      flexibleSpace: const _AppBarBackground(),
    );
  }
}

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Palette.whiteColor.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.arrow_back, color: Palette.whiteColor, size: 20),
      ),
      onPressed: () => Navigator.pop(context),
    );
  }
}

class _AppBarBackground extends StatelessWidget {
  const _AppBarBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xCC5E35B1), Colors.transparent], // Pre-computed opacity
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: const Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Text(
            'User Profile',
            style: TextStyle(
              color: Palette.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}

class _ContentSection extends StatelessWidget {
  final UserModel user;

  const _ContentSection({required this.user});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          SizedBox(height: context.height * 0.01),
          _UserHeader(user: user),
          SizedBox(height: context.height * 0.02),
          _ContactSection(user: user),
          SizedBox(height: context.height * 0.02),
          _CompanySection(user: user),
          SizedBox(height: context.height * 0.02),
          _AddressSection(user: user),
          SizedBox(height: context.height * 0.02),
        ]),
      ),
    );
  }
}

class _UserHeader extends StatelessWidget {
  final UserModel user;

  const _UserHeader({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0x995E35B1), Color(0x668D6EAB)], // Pre-computed colors
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.fromBorderSide(BorderSide(color: Color(0x1AFFFFFF))),
      ),
      child: Row(
        children: [
          //-- user details (header)
          Hero(
            tag: 'avatar-${user.id}',
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [Color(0xFF42A5F5), Color(0xFFAB47BC)]),
                boxShadow: [
                  BoxShadow(color: Color(0x4D000000), blurRadius: 15, offset: Offset(0, 5)),
                ],
              ),

              //-- show the first letter of username
              child: Center(
                child: Text(
                  user.name?[0].toUpperCase() ?? 'U',
                  style: const TextStyle(
                    color: Palette.whiteColor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: context.width * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name ?? 'No Name',
                  style: const TextStyle(
                    color: Palette.whiteColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: context.height * 0.01),
                Text(
                  user.email?.toLowerCase() ?? 'No Email',
                  style: const TextStyle(color: Color(0xCCFFFFFF), fontSize: 14),
                ),
                SizedBox(height: context.height * 0.01),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0x1AFFFFFF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '@${user.username}',
                    style: const TextStyle(color: Color(0xE6FFFFFF), fontSize: 12),
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

class _ContactSection extends StatelessWidget {
  final UserModel user;

  const _ContactSection({required this.user});

  @override
  Widget build(BuildContext context) {
    return _DetailsSection(
      title: "Contact Information",
      children: [
        _DetailTile(icon: Icons.phone_rounded, label: 'Phone', value: user.phone),
        _DetailTile(icon: Icons.email_rounded, label: 'Email', value: user.email),
        _DetailTile(icon: Icons.language_rounded, label: 'Website', value: user.website),
      ],
    );
  }
}

class _CompanySection extends StatelessWidget {
  final UserModel user;

  const _CompanySection({required this.user});

  @override
  Widget build(BuildContext context) {
    return _DetailsSection(
      title: "Company Details",
      children: [
        _DetailTile(icon: Icons.business_rounded, label: 'Company', value: user.company?.name),
        _DetailTile(
          icon: Icons.work_rounded,
          label: 'Catchphrase',
          value: user.company?.catchPhrase != null ? '"${user.company!.catchPhrase!}"' : null,
        ),
        _DetailTile(
          icon: Icons.work_outline_rounded,
          label: 'Business',
          value: user.company?.bs,
        ),
      ],
    );
  }
}

class _AddressSection extends StatelessWidget {
  final UserModel user;

  const _AddressSection({required this.user});

  @override
  Widget build(BuildContext context) {
    return _DetailsSection(
      title: "Address",
      children: [
        _DetailTile(
          icon: Icons.location_on_rounded,
          label: 'Street',
          value: user.address?.street,
        ),
        _DetailTile(
          icon: Icons.location_city_rounded,
          label: 'City',
          value: user.address?.city,
        ),
        _DetailTile(icon: Icons.map_rounded, label: 'Zipcode', value: user.address?.zipcode),
      ],
    );
  }
}

class _DetailsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _DetailsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Color(0x805E35B1), Color(0x4D8D6EAB)]),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.fromBorderSide(BorderSide(color: Color(0x1AFFFFFF))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //-- details section title
          Text(
            title,
            style: const TextStyle(
              color: Palette.whiteColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: context.height * 0.02),
          ...children,
        ],
      ),
    );
  }
}

class _DetailTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;

  const _DetailTile({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          //-- icon
          Container(
            padding: const EdgeInsets.all(17),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF42A5F5), Color(0xFFAB47BC)]),
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(color: Color(0x6642A5F5), blurRadius: 8, offset: Offset(0, 2)),
              ],
            ),
            child: Icon(icon, color: Palette.whiteColor, size: 20),
          ),
          SizedBox(width: context.width * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //-- label
                Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xB3FFFFFF),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: context.height * 0.01),

                //-- value
                Text(
                  value ?? 'Not available',
                  style: const TextStyle(
                    color: Palette.whiteColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

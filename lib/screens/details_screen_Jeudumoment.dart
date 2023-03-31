import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';

class DetailsScreenJeuDuMoment extends StatelessWidget {
  // Informations statiques du jeu
  final String gameName = "Nom du jeu";
  final String gamePublisher = "Éditeur du jeu";
  final String gameDetailedDescription = "Description détaillée du jeu";
  final String headerImageUrl = "URL de l'image d'en-tête";
  final String gameBgContainerUrl = "URL de l'image d'arrière-plan";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1a2025),
      appBar: AppBar(
        title: const Text(
          'Détail du jeu',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'GoogleSansBold',
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff1a2025),
        elevation: 2.5,
        leading: IconButton(
          icon: SvgPicture.asset('res/Icones/back.svg'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.46,
                  child: Image.asset(
                    'res/Jeudumoment/paththumbnail.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  color: const Color(0xff1a2025),
                  child: Html(
                    data: "<h1>ARK: Genesis Part Two!</h1><p><a href=\"https://store.steampowered.com/app/1113410/ARK_Genesis_Season_Pass/\" target=\"_blank\" rel=\"\"  ><img src=\"https://cdn.akamai.steamstatic.com/steam/apps/346110/extras/ARK_GEN2_Steam_Banner_616x181.png?t=1669254188\" /></a><br><br><a href=\"https://www.youtube.com/watch?v=u-VLZjsXWuM\" target=\"_blank\" rel=\"\"  id=\"dynamiclink_0\" >https://www.youtube.com/watch?v=u-VLZjsXWuM</a><br>Your quest for ultimate survival is now complete with the launch of ARK: Genesis Part 2! Survivors will conclude the ARK storyline while adventuring through exotic new worlds with all-new mission-based gameplay. Discover, utilize and master new creatures, new craftable items, weapons, and structures unlike anything you have seen yet! The saga is now complete, and hundreds of hours of new story-oriented ARK gameplay await you!<br><br>Purchased as part of the ARK: Genesis Season Pass you gain access to two new huge story-oriented expansion packs -- Genesis Part 1 and Genesis Part 2 (new!) -- as well as a 'Noglin' Chibi cosmetic, a ‘Shadowmane’ Chibi cosmetic, a new cosmetic armor set, and an in-game, artificially intelligent companion called ‘HLN-A’ who can scan additional hidden Explorer Notes found throughout the other ARKs. <br><br>Features the voiceover talent of David Tennant (Doctor Who, Good Omens) playing the villainous Sir Edmund Rockwell, and Madeleine Madden (The Wheel of Time, Picnic at Hanging Rock, Dora and the Lost City of Gold) as in-game robotic AI companion HLN-A/Helena Walker.<br><br><a href=\"https://store.steampowered.com/app/1113410/ARK_Genesis_Season_Pass/\" target=\"_blank\" rel=\"\"  id=\"dynamiclink_1\" >https://store.steampowered.com/app/1113410/ARK_Genesis_Season_Pass/</a></p><br><h1>About the Game</h1>As a man or woman stranded naked, freezing and starving on the shores of a mysterious island called ARK, you must hunt, harvest resources, craft items, grow crops, research technologies, and build shelters to withstand the elements. Use your cunning and resources to kill or tame &amp; breed the leviathan dinosaurs and other primeval creatures roaming the land, and team up with or prey on hundreds of other players to survive, dominate... and escape!<br><br><img src=\"https://cdn.akamai.steamstatic.com/steam/apps/346110/extras/TameTrainBreedRide.png?t=1669254188\" /><br><br>Dinosaurs, Creatures, &amp; Breeding! -- over 100+ creatures can be tamed using a challenging capture-&amp;-affinity process, involving weakening a feral creature to knock it unconscious, and then nursing it back to health with appropriate food. Once tamed, you can issue commands to your tames, which it may follow depending on how well you’ve tamed and trained it. Tames, which can continue to level-up and consume food, can also carry Inventory and Equipment such as Armor, carry prey back to your settlement depending on their strength, and larger tames can be ridden and directly controlled! Fly a Pterodactyl over the snow-capped mountains, lift allies over enemy walls, race through the jungle with a pack of Raptors, tromp through an enemy base along a gigantic brontosaurus, or chase down prey on the back of a raging T-Rex! Take part in a dynamic ecosystem life-cycle with its own predator &amp; prey hierarchies, where you are just one creature among many species struggling for dominance and survival. Tames can also be mated with the opposite gender, to selectively breed successive generations using a trait system based on recombinant genetic inheritance. This process includes both egg-based incubation and mammalian gestation lifecycles! Or put more simply, raise babies!<br><br><img src=\"https://cdn.akamai.steamstatic.com/steam/apps/346110/extras/FoodWaterTemp.png?t=1669254188\" /><br><br>You must eat and drink to survive, with different kinds of plants &amp; meat having different nutritional properties, including human meat. Ensuring a supply of fresh water to your home and inventory is a pressing concern. All physical actions come at a cost of food and water, long-distance travel is fraught with subsistence peril! Inventory weight makes you move slower, and the day/night cycle along with randomized weather patterns add another layer of challenge by altering the temperature of the environment, causing you to hunger or thirst more quickly. Build a fire or shelter, and craft a large variety of customizable clothing &amp; armors, to help protect yourself against locational damage &amp; extreme temperatures using the dynamic indoor/outdoor insulation calculation system!<br><br><img src=\"https://cdn.akamai.steamstatic.com/steam/apps/346110/extras/HarvestBuildPaint.png?t=1669254188\" /><br><br> By chopping down forests full of trees and mining metal and other precious resources, you can craft the parts to build massive multi-leveled structures composed of complex snap-linked parts, including ramps, beams, pillars, windows, doors, gates, remote gates, trapdoors, water pipes, faucets, generators, wires and all manner of electrical devices, and ladders among many other types. Structures have a load system to fall apart if enough support has been destroyed, so reinforcing your buildings is important. All structures and items can be painted to customize the look of your home, as well as placing dynamically per-pixel paintable signs, textual billboards, and other decorative objects. Shelter reduces the extremes of weather and provides security for yourself and your stash! Weapons, clothing &amp; armor gear can also be painted to express your own visual style.<br><br><img src=\"https://cdn.akamai.steamstatic.com/steam/apps/346110/extras/PlantFarmGrow.png?t=1669254188\" /><br><br>Pick seeds from the wild vegetation around you, plant them in plots that you lay down, water them and nurture them with fertilizer (everything poops after consuming calories, which can then be composted, and some fertilizer is better than others). Tend to your crops and they will grow to produce delicious and rare fruits, which can also be used to cook a plethora of logical recipes and make useful tonics! Explore to find the rarest of plant seeds that have the most powerful properties! Vegetarians &amp; vegans can flourish, and it will be possible to master and conquer the ARK in a non-violent manner!<br><br><img src=\"https://cdn.akamai.steamstatic.com/steam/apps/346110/extras/Summon.png?t=1669254188\" /><br><br>By bringing sufficient rare sacrificial items to special Summon locations, you can capture the attention of the one of the ARK’s god-like mythical creatures, who will arrive for battle. These gargantuan monstrosities provide an end-game goal for the most experienced groups of players and their armies of tames, and will yield extremely valuable progression items if they are defeated.<br><br><img src=\"https://cdn.akamai.steamstatic.com/steam/apps/346110/extras/Tribes.png?t=1669254188\" /><br><br>Create a Tribe and add your friends to it, and all your tames can be commanded by and allied to anyone in your Tribe. Your Tribe will also be able to respawn at any of your home spawn points. Promote members to Tribe Admins to reduce the burden of management. Distribute key items and pass-codes to provide access your shared village!<br><br><img src=\"https://cdn.akamai.steamstatic.com/steam/apps/346110/extras/RPG.png?t=1669254188\" /><br><br>All items are crafted from Blueprints that have variable statistics and qualities, and require corresponding resources. More remote and harsh locales across the ARK tend to have better resources, including the tallest mountains, darkest caves, and depths of the ocean! Level-Up your player character by gaining experience through performance actions, Level-Up your tames, and learn new &quot;Engrams&quot; to be able to craft Items from memory without the use of blueprints, even if you die! Customize the underlying physical look of your character with hair, eye, and skin tones, along with an array of body proportion modifiers. As you explore the vast ARK, you'll find clues left by other Survivors who have made the ARK their home in ages past, in the form of collectible detailed 3D &quot;Explorer Notes&quot;. By uncovering all of these, you can begin to piece together the true nature of the ARK, and discover its purpose!<br><br><img src=\"https://cdn.akamai.steamstatic.com/steam/apps/346110/extras/HardcoreMechanics.png?t=1669254188\" /><br><br>Everything you craft has durability and will wear-out from extended use if not repaired, and when you leave the game, your character remains sleeping in the persistent world. Your inventory physically exists in boxes or on your character in the world. Everything can be looted &amp; stolen, so to achieve security you must build-up, team-up, or have tames to guard your stash. Death is permanent, and you can even knock out, capture, and force-feed other players to use them for your own purposes, such as extracting their blood to for transfusions, harvesting their fecal matter to use as fertilizer, or using them as food for your carnivorous tames!<br><br><img src=\"https://cdn.akamai.steamstatic.com/steam/apps/346110/extras/ExploreAndDiscover.png?t=1669254188\" /><br><br>The mysterious ARK is a formidable and imposing environment, composed of many natural and unnatural structures, above-ground, below-ground, and underwater. By fully exploring its secrets, you’ll find the most exotic procedurally randomized creatures and rare blueprints. Also to be found are Explorer Notes that are dynamically updated into the game, written by previous human denizens of the ARK from across the millennia, creatively detailing the creatures and backstory of the ARK and its creatures. Fully develop your in-game ARK-map through exploration, write custom points of interest onto it, and craft a Compass or GPS coordinates to aid exploring with other players, whom you can communicate with via proximity text &amp; voice chat, or long-distance radio. Construct &amp; draw in-game signs for other players to help them or lead them astray...  And yet.. how do you ultimately challenge the Creators and Conquer the ARK? A definitive end-game is planned.<br><br><img src=\"https://cdn.akamai.steamstatic.com/steam/apps/346110/extras/LargeWorld.png?t=1669254188\" /><br><br>On the 100+ player servers, your character, everything you built, and your tames, stay in-game even when you leave. You can even physically travel your character and items between the network of ARK's by accessing the Obelisks and uploading (or downloading) your data from the Steam Economy! A galaxy of ARKs, each slightly different than the previous, to leave your mark on and conquer, one at a time -- special official ARKs will be unveiled on the World-map for limited times in singular themed events with corresponding limited-run items! Furthermore, you can now design or randomize your own unique 'Procedurally Generated ARKs', for infinite replayability and endless surprises.<br><br><img src=\"https://cdn.akamai.steamstatic.com/steam/apps/346110/extras/RobustSteamWorkshop.png?t=1669254188\" /><br><br>You can play single-player local games, and bring your character and items between unofficial player-hosted servers, back and forth from singleplayer to multiplayer. Mod the game, with full Steam Workshop support and customized Unreal Engine 4 editor. See how we built our ARK using our maps and assets as an example. Host your own server and configure your ARK precisely to your liking. We want to see what you create!<br><br><img src=\"https://cdn.akamai.steamstatic.com/steam/apps/346110/extras/HighEndNextGenVisuals.png?t=1669254188\" /><br><br>The over-the-top hyper real imagery of the ARK its creatures is brought to expressive life using a highly-customized Unreal Engine 4, with fully dynamic lighting &amp; global illumination, weather systems (rain, fog, snow, etc) &amp; true-to-life volumetric cloud simulation, and the latest in advanced DirectX11 and DirectX12 rendering techniques. Music by award-winning composer of &quot;Ori and the Blind Forest&quot;, Gareth Coker!",
                    style: <String, Style>{
                      'body': Style(
                        fontSize: FontSize(15.0),
                        color: Colors.white,
                        fontFamily: 'Proxima',
                      ),
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.387,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xff1e262c),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Color(0x4c000000),
                      offset: Offset(0, 0),
                      blurRadius: 2.5,
                    ),
                  ],
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('res/Jeudumoment/page_bg.jpg'),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('res/Jeudumoment/box.jpg'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Text(
                              'ARK: Survival Evolved',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xffffffff),
                                fontFamily: 'Proxima',
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Studio Wildcard',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffffffff),
                                fontFamily: 'Proxima',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

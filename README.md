# Terran Exile

[![mcman badge](https://img.shields.io/badge/uses-mcman-purple?logo=github)](https://github.com/ParadigmMC/mcman)

<!-- run 'mcman md' to update! -->

<!--start:mcman-server-->
| Version | Type                                       |
| ------- | ------------------------------------------ |
| 1.20.2  | [Paper](https://papermc.io/software/paper) |
<!--end:mcman-server-->

## Setup

1. Install [mcman](https://github.com/ParadigmMC/mcman)
2. Run the build script: `./build.sh` on Unix, `./build.bat` on Windows
3. Run the start script: `./start.sh` on Unix, `./start.bat` on Windows

### Discord Bot

1. Add a `DISCORD_TOKEN` entry to the `secrets.secret` file in the Denizen plugin folder
2. Run the `discord` command to set channel IDs<br>
    a. `discord bridge <id>`: Public Discord-Minecraft bridge channel
    b. `discord admin <id>`: Admin-only logs channel

## Plugins

<!--start:mcman-addons-->
| Name                                                                          | Description                                                                                                                                                                                                                                                                                                                                                                                              | Version                                                                               |
| ----------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
| [Denizen_Developmental](https://ci.citizensnpcs.co/job/Denizen_Developmental) | A compilation of useful traits to further extend your Citizens2 NPCs, as well as a fully-featured scripting engine (dScript) for truly powerful server customization.     Note that this page is Developmental Builds! This means they are unstable and should NOT be used on live (production servers), only on testing or staging servers.  For public servers, use the stable release builds instead! | latest / `first`                                                                      |
| [Citizens2](https://ci.citizensnpcs.co/job/Citizens2)                         | The best NPC plugin                                                                                                                                                                                                                                                                                                                                                                                      | latest / `first`                                                                      |
| [Simple Voice Chat](https://modrinth.com/mod/simple-voice-chat)               | A working voice chat in Minecraft!                                                                                                                                                                                                                                                                                                                                                                       | b2fQucaC                                                                              |
| `LuckPerms-Bukkit-5.4.108.jar`                                                | LuckPerms                                                                                                                                                                                                                                                                                                                                                                                                | [URL](https://download.luckperms.net/1521/bukkit/loader/LuckPerms-Bukkit-5.4.108.jar) |
| [MilkBowl/Vault](https://github.com/MilkBowl/Vault)                           | Vault of common APIs for Bukkit Plugins                                                                                                                                                                                                                                                                                                                                                                  | 1.7.3 / `Vault.jar`                                                                   |
| [dDiscordBot](https://ci.citizensnpcs.co/job/dDiscordBot)                     |                                                                                                                                                                                                                                                                                                                                                                                                          | latest / `first`                                                                      |
<!--end:mcman-addons-->

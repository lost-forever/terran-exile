ability_command:
    type: command
    name: ability
    description: Applies an ability to a player's held item
    usage: /ability <&lt>id<&gt> <&lt>base|super<&gt> (<&lt>player<&gt>)
    required: 2
    permission: terran_exile.ability
    tab completions:
        1: <server.flag[abilities].keys>
        2: base|super
        3: <server.online_players.parse[name]>
    script:
    - inject cmd_args
    # Check input player, or current player if none
    - if <context.args.size> >= 3:
        - define user <context.args.get[3]>
        - inject cmd_player
    - else:
        - define user <player>
    # Check ability ID
    - define id <context.args.first>
    - if not <server.has_flag[abilities.<[id]>]>:
        - define reason "Invalid ability ID!"
    # Check ability level
    - define level <context.args.get[2]>
    - if <[level]> not in base|super:
        - define reason "Invalid ability level!"
    # Check that player is holding item
    - define item <[user].item_in_hand>
    - if <[item].material.name> == air:
        - define reason "Missing held item!"
    - inject cmd_err
    # Apply ability and set back to inventory
    - define result <[item].proc[item_grant_ability].context[<[id]>]>
    - inventory set o:<[result]> slot:hand d:<[user].inventory>

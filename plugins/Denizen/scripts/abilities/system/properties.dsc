ability_get_name:
    type: procedure
    debug: false
    definitions: ability[Ability data script] | level['base' or 'super']
    script:
    - define name <[ability].data_key[name]>
    - define format <[level].equals[super].if_true[<bold>].if_false[<empty>]>
    - define gradient <[ability].data_key[<[level]>.colors]>
    - determine <&gradient[<[gradient].with[style].as[hsb]>]><[format]><[name]>

ability_get_description:
    type: procedure
    debug: false
    definitions: ability[Ability data script] | level['base' or 'super'] | color[The description color]
    script:
    - define lines <[ability].data_key[<[level]>.description]>
    - determine <[lines].parse_tag[<[color].if_null[<dark_gray>]><[parse_value]>]>

ability_get_lore:
    type: procedure
    debug: false
    definitions: ability[Ability data script] | level['base' or 'super']
    script:
    - define name <[ability].proc[ability_get_name].context[<[level]>]>
    - define description <[ability].proc[ability_get_description].context[<[level]>]>
    - determine <[name].as[list].include[<[description]>]>

ability_get_proxies:
    type: procedure
    debug: false
    definitions: ability[Ability data script] | level['base' or 'super']
    script:
    - determine <[ability].data_key[<[level]>.proxies].if_null[null]>

ability_get_icon:
    type: procedure
    debug: false
    definitions: ability[Ability data script]
    script:
    - define item <[ability].data_key[icon].as[item]>
    - adjust def:item display:<[ability].proc[ability_get_name].context[base]>
    - adjust def:item lore:<[ability].proc[ability_get_description].context[base|<gray>]>
    - determine <[item]>

ability_get_data_map:
    type: procedure
    debug: false
    definitions: ability[Ability data script] | ability_id[The ability script ID] | level['base' or 'super'] | map[The base data map]
    script:
    - define map <[map].include[id=<[ability_id]>;level=<[level]>;<[ability_id]>=true]>
    - define active <[ability].data_key[<[level]>.active].if_null[null]>
    - if <[active]> != null:
        - define existing <[map].get[active].if_null[<map>]>
        - define map <[map].with[active].as[<[existing].include[<[active]>]>]>
    - determine <[map]>

abilities_load:
    type: world
    debug: false
    events:
        after scripts loaded:
        - define scripts <util.scripts.filter_tag[<[filter_value].data_key[te$ability].exists>]>
        - define map <[scripts].parse[name].map_with[<[scripts]>]>
        - flag server abilities:<[map]>
        - debug log "Ability scripts loaded (<[map].size>): <[map].keys.parse_tag[<aqua><[parse_value]>].separated_by[<reset>, ]>"

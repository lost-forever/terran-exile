exp_give:
    type: task
    definitions: amount
    script:
    - if not <player.has_flag[exp]>:
        - flag <player> exp:0
    - if <player.flag[exp]> > 256:
        # TODO: reward system
        - stop
    - flag <player> exp:+:<[amount]>
    - if <player.flag[exp]> > 256:
        - flag <player> exp:256
    - adjust <player> fake_experience:<player.flag[exp].div[256].min[0.99]>

exp_listener:
    type: world
    events:
        on player absorbs experience:
        - determine passively cancelled
        - adjust <player> fake_pickup:<context.entity>
        - run exp_give def:<context.entity.experience>
        - remove <context.entity>

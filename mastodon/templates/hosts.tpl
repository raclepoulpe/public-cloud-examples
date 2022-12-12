all:
    hosts:
        mastodon_server:
            ansible_host: ${mastodonIP}
            ansible_user: ubuntu

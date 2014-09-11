from ac_flask.hipchat import Addon, room_client, sender
from flask import Flask

addon = Addon(app=Flask(__name__),
              key="test-addon",
              name="Test AddOn",
              allow_room=True,
              scopes=['send_notification'])

@addon.webhook(event="room_enter")
def room_entered():
    room_client.send_notification('hi: %s' % sender.name)
    return '', 204


if __name__ == '__main__':
    addon.run()

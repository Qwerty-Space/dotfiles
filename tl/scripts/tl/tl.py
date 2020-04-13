import sys
from os import path
from telethon import TelegramClient, custom, events, sync, functions as f, types as t
from telethon.tl.custom import Button

try:
    session = sys.argv[1]
except IndexError:
    session = "default"

script_dir = path.dirname(path.realpath(__file__))
client = TelegramClient(path.join(script_dir, session), 6, "eb06d4abfb49dc3eeb1aeb98ae0f581e").start()

print(client.get_me().first_name)

import sys
from os import path
from telethon import TelegramClient, custom, events, sync, functions as f, types as t
from telethon.tl.custom import Button
import config

try:
    session = sys.argv[1]
except IndexError:
    session = "default"

script_dir = path.dirname(path.realpath(__file__))
client = TelegramClient(path.join(script_dir, session), config.id, config.hash).start()
c = client

print(client.get_me().first_name)

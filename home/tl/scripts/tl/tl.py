import sys
import code
from os import path
from telethon import TelegramClient, custom, events, sync, functions as f, types as t
from telethon.tl.custom import Button

# set the script dir and import config
script_dir = path.dirname(path.realpath(__file__))
sys.path.append(script_dir)
import config

def main():
    try:
        session = sys.argv[1]
    except IndexError:
        session = "default"


    client = TelegramClient(path.join(
        script_dir, session), config.id, config.hash).start()

    code.interact(banner=f"Logged in as:  {client.get_me().first_name} ",
                  local=locals())

if __name__ == "__main__":
    main()


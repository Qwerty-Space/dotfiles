import os
import argparse
import subprocess

parser = argparse.ArgumentParser(description="Initialise dotfiles by creating the directory struture")
parser.add_argument("-d", "--dry", default=False, action="store_const", const=True)
parser.add_argument("-p", "--path", default=".", action="store")
parser.add_argument("-t", "--target", default="..", action="store")

args = parser.parse_args()


def create_dirs(packages):
    directories = set()
    asked = False
    for root, dirs, files in os.walk(path, topdown=False):
        for name in dirs:
            if not asked:
                asked = True
                strip = input(
                    "\n" + os.path.join(root, name) +
                    "\nHow many directories deep are the required files?  (default: 2):  "
                ) or 2
                strip = int(strip)

            # Split the path up and strip the first few directories
            dir = (os.path.join(root, name)).split("/")[strip:]
            # join the path back together
            if not dir:
                continue
            directories.add(os.path.join(*dir))

    for name in directories:
        name_dir = os.path.split(name)
        dir = os.path.join(target, name.lstrip("/"))#.replace("dot-", ".")
        print(dir)
        if not args.dry:
            os.makedirs(dir, exist_ok=True)


def stow_dirs(packages):
    # directories = os.listdir(args.path)
    if args.dry:
        print("Directories to stow:  ", packages)
        return

    for package in packages:
        subprocess.run(["stow", "-t", target, package])


def main():
    packages = os.listdir(path)

    create = input("Create directories?  [Y/n]:  ").casefold() or "y"
    if create.startswith("y"):
        create_dirs(packages)

    stow = input("Stow dotfiles?  [Y/n]:  ").casefold() or "y"
    if stow.startswith("y"):
        stow_dirs(packages)


if __name__ == "__main__":
    path = os.path.expanduser(os.path.expandvars(args.path))
    target = os.path.expanduser(os.path.expandvars(args.target))
    print("Settings")
    print("Dry run: ", args.dry)
    print("Dotfiles path: ", args.path)
    print("Target: ", target)

    try:
        main()
    except KeyboardInterrupt:
        exit

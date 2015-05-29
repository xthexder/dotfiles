UNAME := $(shell uname)

LN_FLAGS := -s
ifeq ($(UNAME), Linux)
	LN_FLAGS := $(LN_FLAGS) -T
else ifeq ($(UNAME), Darwin)
	LN_FLAGS := $(LN_FLAGS) -h
endif

all: submodules kantan-build Xresources matcher-build link zshlink

matcher-build:
	cd matcher; make

kantan-build:
	cd kantan; ./kantan schemes/default

Xresources:
	cat .Xresources > ~/.Xresources
	cat kantan/output/Xresources >> ~/.Xresources

.mpd:
	mkdir -p .mpd/playlists
	touch .mpd/mpd.{db,log,pid,state}

link: .zsh .zshrc .vim .vimrc .gitconfig .gitignore_global .inputrc .tmux.conf .config .ctags .mpd .mpdconf .xbindkeysrc .xinitrc .ncmpcpp .slate .mpv
	$(foreach file, $^, ln $(LN_FLAGS) $(CURDIR)/$(file) ~/$(file) || true; )

zshlink: directories.zsh grep.zsh
	$(foreach file, $^, test -h $(CURDIR)/.zsh/oh-my-zsh/lib/$(file) || (rm $(CURDIR)/.zsh/oh-my-zsh/lib/$(file) && ln -s $(CURDIR)/$(file) $(CURDIR)/.zsh/oh-my-zsh/lib/$(file)); )

submodules:
	git submodule init
	git submodule update


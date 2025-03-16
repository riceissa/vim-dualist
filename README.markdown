# dualist.vim

`dualist.vim` alters `listchars` based on the current mode (normal vs insert).

## Feature highlights

- Trailing whitespace appears in normal mode but disappears in insert mode.
  When you're inserting text, you don't want to see every new space character
  as a visible space, but after you're done inserting text, you _do_ want to see
  if there's any trailing whitespace.

  - This plugin does not delete trailing whitespace. For that, I recommend
    making a `~/.editorconfig` file with `trim_trailing_whitespace = true`.

## Installation

The plugin works with the major plugin managers. For instance
with [vim-plug][plug] just place in your `.vimrc`:

    Plug 'riceissa/vim-dualist'

## License

Distributed under the same terms as Vim itself. See `:help license`.

[plug]: https://github.com/junegunn/vim-plug

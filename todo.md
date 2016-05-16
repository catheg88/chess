- implement the singleton class on the null piece object:

require 'singleton'

class NullPiece
  include Singleton

- don't allow the pieces to replace themselves

- pieces can make any crazy moves they want

- if a king is in check and an opposing pawn is adjacent, it errors out while checking each piece's options

- valid move allows a pawn to move 2 steps initially, even if it's through a piece



works:
-in_check?

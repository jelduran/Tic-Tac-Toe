# spec/board_spec.rb

require './lib/board'

describe Board do
  let(:board) { Board.new }

  describe '#current_board' do
    it 'returns an empty board' do
      expect(board.current_board).to eql("\n   |   |   \n----------- \n   |   |   \n----------- \n   |   |   \n")
    end
  end

  describe '#reset' do
    it 'checks if all positions in board are empty after reset' do
      board.move(0, 0, 'X')
      expect { board.reset }.to change(board, :positions).to [[' ', ' ', ' '], [' ', ' ', ' '], [' ', ' ', ' ']]
    end

    it 'checks if number of moves is zero after reset' do
      board.move(0, 0, 'X')
      expect { board.reset }.to change(board, :move_number).to 0
    end

    it 'checks if winner is set to false after reset' do
      board.move(0, 0, 'X')
      board.move(1, 0, 'O')
      board.move(0, 1, 'X')
      board.move(1, 1, 'O')
      board.move(0, 2, 'X')
      expect { board.reset }.to change(board, :winner).to false
    end
  end

  describe '#move' do
    it 'returns if there is a winner after the fourth move' do
      board.move(0, 0, 'X')
      board.move(0, 2, 'O')
      board.move(1, 1, 'X')
      board.move(1, 2, 'O')
      expect(board.move(2, 2, 'X')).to eql(board.winner)
    end
  end

  describe '#check_winner' do
    it 'checks if there is a winner in row' do
      board.move(0, 0, 'X')
      board.move(0, 1, 'X')
      expect(board.check_winner(0, 2, 'X')).not_to eql(true)
    end

    it 'checks if there is a winner in column' do
      board.move(0, 0, 'X')
      board.move(1, 0, 'X')
      expect(board.check_winner(2, 0, 'X')).not_to eql(true)
    end

    it 'checks if there is a winner in diagonal from left to right' do
      board.move(0, 0, 'X')
      board.move(1, 1, 'X')
      expect(board.check_winner(2, 2, 'X')).not_to eql(true)
    end

    it 'checks if there is a winner in diagonal from right to left' do
      board.move(0, 2, 'X')
      board.move(1, 1, 'X')
      expect(board.check_winner(2, 0, 'X')).not_to eql(true)
    end

    it 'checks if there is a draw' do
      board.move(0, 0, 'X')
      board.move(0, 1, 'O')
      board.move(0, 2, 'X')
      board.move(1, 0, 'O')
      board.move(1, 1, 'X')
      board.move(1, 2, 'O')
      board.move(2, 0, 'X')
      board.move(2, 1, 'O')
      expect(board.check_winner(2, 2, 'X')).not_to eql(true)
    end
  end

  describe '#empty_position?' do
    it 'returns true if position is empty' do
      board.move(0, 0, 'X')
      expect(board.empty_position?(0, 1)).to eql(true)
    end

    it 'returns false if position is taken' do
      board.move(1, 1, 'X')
      expect(board.empty_position?(1, 1)).to eql(false)
    end
  end
end

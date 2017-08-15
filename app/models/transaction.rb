class Transaction < ApplicationRecord

  enum result: [:sucess, :failed]
end

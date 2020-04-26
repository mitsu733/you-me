class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

private

def tag_word(word)
  word.body.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/, "")
end
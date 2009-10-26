class Level < ActiveRecord::Base
  acts_as_list :scope => :game

  belongs_to :game
  has_many :hints, :order => "delay ASC"

  validates_presence_of :name,
    :message => "Вы не ввели название задания"

  validates_presence_of :text,
    :message => "Вы не ввели текст задания"

  validates_presence_of :correct_answers,
    :message => "Вы не ввели правильные ответы"

  validates_presence_of :game

  def next
    lower_item
  end
end
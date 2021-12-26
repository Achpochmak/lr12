# frozen_string_literal: true

class Polyndrom < ApplicationRecord
  validates :param, presence: true, uniqueness: true
  validates :index, presence: true
  validates :num, presence: true
  validates :rev, presence: true
  validates :theory, presence: true
end

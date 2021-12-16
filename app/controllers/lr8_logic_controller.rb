# frozen_string_literal: true

class IndexController < ApplicationController
  skip_before_action :output, raise: false

  def input; end

  def show
    respond_to do |format|
      format.xml { render xml: Polyndrom.all.to_xml }
      format.html { @all = Polyndrom.all }
    end
  end

  def output
    num = params[:num]

    palindromes = find_palindromes(num)

    data = if palindromes.nil?
             { message: "Неверные параметры запроса (num = #{num})" }
           else
             index = []
             numbers = []
             rev = []
             theory = []
             palindromes.each do |elem|
               index << elem[0]
               numbers << elem[1]
               rev << elem[2]
               theory << elem[3]
             end
           end

    Polyndrom.create(param: num.to_i,
                     index: index.join(' '),
                     num: numbers.join(' '),
                     rev: rev.join(' '),
                     theory: theory.join(' '))
    unless Polyndrom.exists?(param: num)

      @result = Array.new { Array.new(4) }
      @result[0] = Polyndrom.find_by(param: num).index.split(' ').map { |n| String(n.to_i) }
      @result[1] = Polyndrom.find_by(param: num).num.split(' ').map { |n| String(n) }
      @result[2] = Polyndrom.find_by(param: num).rev.split(' ').map { |n| String(n) }
      @result[3] = Polyndrom.find_by(param: num).theory.split(' ').map { |n| String(n) }

      respond_to do |format|
        format.html { render inline: data.to_s }
        format.xml { render xml: data.to_xml }
      end
    end
  end

  protected

  def show_db
    render xml: Polyndrom.all.to_xml
  end


  private

  def find_palindromes(number)
    if (number != '') && (number.to_i.to_s != '0')

      num = number.to_i.to_s

      @result = []
      i = 0
      while num != num.reverse && @result.size < 100
        i += 1

        @result << [i, num.to_i, num.reverse.to_i, 'Нет']
        num = (num.to_i + num.reverse.to_i).to_s
      end
      @result << if @result.size != 100
                   [i + 1, num.to_i, num.reverse.to_i, 'Да']
                 else
                   [i + 1, num.to_i, num.reverse.to_i, 'Нет']
                 end
      @result
    end
  end
end

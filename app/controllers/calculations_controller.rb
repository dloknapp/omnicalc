class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(" ", "").length

    a = @text.split
    @word_count = a.length

    a_downcase = []
    a.each do |string|
        cleaned = string.gsub(/[^0-9A-Za-z]/, '')
        a_downcase.push(cleaned.downcase)
    end

    @occurrences = a_downcase.count(@special_word)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================
    rate = @apr / 100/ 12
    nper = @years * 12

    pmt = (rate * @principal * (( 1 + rate) ** nper)) / ((1 + rate) ** nper - 1)

    @monthly_payment = pmt

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds / 60
    @hours = @minutes / 60
    @days = @hours / 24
    @weeks = @days / 7
    @years = @days / 365.25

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    midpoint = @count / 2
    med = 0
    if @count % 2 == 1
        med = @sorted_numbers[midpoint]
    else
        med = (@sorted_numbers[midpoint] + @sorted_numbers[midpoint - 1])/2
    end

    @median = med

    @sum = @numbers.sum

    @mean = @sum / @count

    squared_differences = []
    @sorted_numbers.each do |number|
        diff = @mean - number
        diff_squared = diff ** 2
        squared_differences.push diff_squared
    end

    @variance = squared_differences.sum / squared_differences.length

    @standard_deviation = @variance ** 0.5

    # created array to hold the count of each element
    occurrences = []
    @numbers.each do |number|
        occurrences.push @numbers.count(number)
    end

    # find the index of the max number and return it
    index = occurrences.index(occurrences.max)
    @mode = @numbers[index]

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end

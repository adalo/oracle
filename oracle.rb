class Oracle
	def ask
		[true, false].sample
	end
end

class Runner
	def initialize(options={})
		default_run_size = 1000
		@run_length = options[:run_length].to_i || default_run_size
	end
	
	def run
		oracle = Oracle.new
		results = []

		@run_length.times { results.push(oracle.ask) }

		results
	end
end

class TruthChecker
	def initialize(options={})
		@threshold = options[:threshold].to_i
	end
	
	def check(results)
		number_true = results.count(true).to_f
		percent_true = number_true / results.length * 100
		puts "#{percent_true.to_i}% true!" if percent_true > @threshold
	end
end


runs = 100 # number of runs to check for truth
run_length = 1000 # number of samples per run
truth_threshold = 65 # % of 'true' responses per run to trigger a log event

runner = Runner.new(run_length: run_length)
checker = TruthChecker.new(threshold: truth_threshold)

puts "Running #{runs} times!"

runs.times { checker.check(runner.run) }

puts "Done!"
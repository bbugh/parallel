require './spec/cases/helper'

# ruby-progressbar ignores the format string you give it
# unless the output is a TTY.  When running in the test,
# the output is not a TTY, so we cannot test that the format
# string you pass overrides parallel's default.  So, we pretend
# that stdout is a TTY to test that the options are merged
# in the correct way.
tty_stdout = $stdout
class << tty_stdout
  def tty?
    true
  end
end

require 'ruby-progressbar'

progress = ProgressBar.create(
  title: "Filling Halflings With Pie",
  progress_mark: "▒",
  format: "%t %C %w",
  output: tty_stdout,
  total: 3.14159 # this should be replaced by the parallel job total
)

Parallel.map(1..20, progress: progress) do
  progress.log "progress.log output!"
  2
end

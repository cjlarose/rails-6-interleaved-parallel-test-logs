# Add the ability to configure "global" (process-local) tags that are shared
# among all threads of a process. Threads still maintain thread-local tag
# stacks as normal, but when printing log lines, the global tags are printed
# first.
# This idea was proposed here:
# https://github.com/rails/rails/issues/28156#issuecomment-292295681
module ActiveSupport
  module TaggedLogging
    module Formatter
      def global_tags=(*tags)
        tags.flatten.reject(&:blank?).tap do |new_tags|
          @global_tags = new_tags
        end
      end

      def global_tags
        @global_tags ||= []
      end

      def tags_text
        tags = global_tags + current_tags
        tags.collect { |tag| "[#{tag}] " }.join if tags.any?
      end
    end

    delegate :global_tags=, to: :formatter
  end
end

# Add the ability to add after-fork hooks that run _before_ previously-declared
# after-fork hooks
module ActiveSupport
  module Testing
    class Parallelization
      def self.prepend_after_fork_hook(&blk)
        @@after_fork_hooks.prepend blk
      end
    end
  end
end

# Add tags to logger in `prepend_after_fork_hook` so that database setup
# log lines are tagged appropriately in addition to log lines emitted during
# test case execution
ActiveSupport::Testing::Parallelization.prepend_after_fork_hook do
  |worker_number|
  Rails.logger.global_tags = [worker_number]
end

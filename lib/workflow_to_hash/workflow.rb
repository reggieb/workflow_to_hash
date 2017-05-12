module WorkflowToHash
  class Workflow

    def self.for(workflow)
      new(workflow).send(:to_hash)
    end

    private
    attr_reader :workflow
    def initialize(workflow)
      raise_unknown_workflow_error unless is_public_method?(workflow)
      @workflow = send workflow
    end

    def to_hash
      make_hash workflow
    end

    # Converts [:a, :b, :c] into
    # {:a => :b, :b => :c}
    def make_hash(array)
      all_but_last = array[0..-2]
      all_but_first = array[1..-1]
      pairs = [all_but_last, all_but_first].transpose
      Hash[pairs]
    end

    def is_public_method?(name)
      public_methods.include?(name.to_sym)
    end

    def raise_unknown_workflow_error
      raise UnknownWorkflowError.new 'Workflow name must match a public method'
    end
  end
end

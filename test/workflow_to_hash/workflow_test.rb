require 'test_helper'

module WorkflowToHash
  class WorkflowTest < Minitest::Test

    def test_make_hash
      array = [:a, :b, :c]
      hash = {a: :b, b: :c}
      assert_equal hash, workflow.send(:make_hash, array)
    end

    def test_initialization_with_unknown_method
      assert_raises UnknownWorkflowError do
        DummyWorkflow.new(:unknown)
      end
    end

    def test_initialization_with_private_method
      assert_raises UnknownWorkflowError do
        DummyWorkflow.new(:to_hash)
      end
    end

    def test_workflow
      assert_equal workflow.numbers, workflow.send(:workflow)
    end

    def test_to_hash
      assert_equal numbers_as_hash, workflow.send(:to_hash)
    end

    def test_for
      assert_equal numbers_as_hash, DummyWorkflow.for(:numbers)
    end

    def workflow
      @workflow ||= DummyWorkflow.new(:numbers)
    end

    def numbers_as_hash
      {one: :two, two: :three}
    end
  end
end

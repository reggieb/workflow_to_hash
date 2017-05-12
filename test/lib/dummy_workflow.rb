require 'workflow_to_hash'

class DummyWorkflow < WorkflowToHash::Workflow

  def numbers
    [:one,:two,:three]
  end

end

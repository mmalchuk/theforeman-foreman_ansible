class RenameAnsibleJobCategories < ActiveRecord::Migration[5.1]
  def up
    User.as_anonymous_admin do
      updated_templates = ['Power Action - Ansible Default',
                           'Puppet Run Once - Ansible Default']
      JobTemplate.where(:name => updated_templates).all.each do |job_template|
        next if job_template.job_category =~ /^Ansible/
        job_template.job_category = "Ansible #{job_template.job_category}"
        job_template.save!
      end

      service_template = JobTemplate.where(:name => 'Service Action - Ansible Default').first
      service_template.job_category = 'Ansible Services'
      service_template.save!
    end
  end
end

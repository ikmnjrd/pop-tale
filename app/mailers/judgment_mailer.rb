class JudgmentMailer < ApplicationMailer
    #default to: -> { Admin.pluck(:email) },
    #        from: 'notification@example.com'
    default to: 'ikmonjara2rnmt@gmail.com'
   
    def new_registration(painting)
      @painting = painting
      mail(subject: "New Painting id: #{@painting.id}",
            template_path: 'layouts',
            template_name: 'judgment')
    end
  end
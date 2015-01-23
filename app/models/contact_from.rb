class ContactFrom < MailForm::Base
  attribute :name,          :validate => true
  attribute :email,         :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message_title, :validate => true
  attribute :message,       :validate => true

  def headers
    {
      :subject => "Undersky",
      :to => "Richardlonesteen@gmail.com",
      :from => %("#{name}" <#{email}>)
    }
  end
end
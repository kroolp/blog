class ArticleMailer < ApplicationMailer
  def article_destroy_info(article)
    @article = article

    mail to: @article.user.email, subject: 'Twój artykuł został usunięty'
  end
end

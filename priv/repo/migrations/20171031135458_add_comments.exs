defmodule Discuss.Repo.Migrations.AddComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :content, :string
      add :user_id, references(:users, on_delete: :delete_all)
      add :topic_id, references(:topics, on_delete: :delete_all)

      timestamps()
    end
  end
end

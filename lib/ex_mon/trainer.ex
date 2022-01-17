defmodule ExMon.Trainer do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Repo

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "trainers" do
    field :name, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    timestamps()
    field :deleted_at, :naive_datetime
  end

  @required_params [:name, :password_hash]
  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password_hash, min: 6)
    |> put_password_hash
  end

  def create_trainer(params) do
    params
    |> Trainer.changeset()
    |> Repo.insert()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
  
end

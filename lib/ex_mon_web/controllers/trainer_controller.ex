defmodule ExMonWeb.TrainerController do
  use ExMonWeb, :controller
  
  alias ExMon.Trainer

  def get_all(conn, _params) do
  end

  def get_by_id(conn, params) do
  end

  def create(conn, params) do
   {:ok, trainer} = Trainer.create_trainer(params)

   conn
   |> put.status(:created)
   |> json(%{})
  end

  def update(conn, params) do
  end

  def delete(conn, params) do
  end
end

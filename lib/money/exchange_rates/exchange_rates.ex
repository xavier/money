defmodule Money.ExchangeRates do
  @moduledoc """
  Implements functions to retrieve exchange rates from Open Exchange Rates.

  An `app_id` is required and is configured in `config.exs` of the appropriate
  environment configuration file.  The `app_id` can be configured as either
  a string or as a tuple `{:system, "shell variable name"}` to ease runtime
  retrieval of the `app_id`.

  ##Example configurations:

      config :ex_money,
        open_exchange_rates_app_id: "app_id_string",
        open_exchange_rates_retrieve_every: 360_000

      config :ex_money,
        open_exchange_rates_app_id: {:system, "OPEN_EXCHANGE_RATES_APP_ID"},
        open_exchange_rates_retrieve_every: 360_000
  """

  @doc """
  Defines the behaviour to retrieve exchange rates from an external
  data source
  """
  @callback get_latest_rates() :: {:ok, %{}} | {:error, binary}

  @doc """
  Return the latest exchange rates.

  Returns:

  * `{:ok, rates}` if exchange rates are successfully retrieved.  `rates` is a map of
  exchange rate converstion.

  * `:error` if no exchange rates are available
  """
  def latest_rates do
    try do
      case :ets.lookup(:exchange_rates, :rates) do
        [{:rates, rates}] -> {:ok, rates}
        [] -> {:error, "No exchange rates were found"}
      end
    rescue
      ArgumentError -> {:error, "No exchange rates are available"}
    end
  end

  @doc """
  Return the timestamp of the last successful retrieval of exchange rates

  ##Example:

      Money.ExchangeRates.last_updated
      #> {:ok,
       %DateTime{calendar: Calendar.ISO, day: 20, hour: 12, microsecond: {731942, 6},
        minute: 36, month: 11, second: 6, std_offset: 0, time_zone: "Etc/UTC",
        utc_offset: 0, year: 2016, zone_abbr: "UTC"}}
  """
  def last_updated do
    case :ets.lookup(:exchange_rates, :last_updated) do
      [{:last_updated, timestamp}] -> {:ok, timestamp}
      [] -> :error
    end
  end

  @doc """
  Retrieves exchange rates from the configured exchange rate api module.

  This call is the public api to retrieve results from an external api service
  or other mechanism implemented by an api module.  This method is typically
  called periodically by `Money.ExchangeRates.Retriever.handle_info/2` but can
  called at any time by other functions.
  """
  @exchange_rate_api Money.get_env(:api_module, Money.ExchangeRates.OpenExchangeRates)
  def get_latest_rates do
    @exchange_rate_api.get_latest_rates()
  end
end
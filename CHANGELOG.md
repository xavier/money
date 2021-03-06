## Changelog for Ex_Money v0.1.4 May 29, 2017

### Enhancements

* Updated to `ex_cldr` version 0.4.0

## Changelog for Ex_Money v0.1.3 April 27, 2017

### Enhancements

* Updated to `ex_cldr` version 0.2.0

* Supported only on Elixir 1.4.x

## Changelog for Ex_Money v0.1.2 April 17, 2017

### Enhancements

* Updated to `ex_cldr` version 0.1.3 to reflect updated CLDR repository version 30.0.1 and revised api for `Cldr.Currency.validate_currency_code/1`

## Changelog for Ex_Money v0.1.1 April 11, 2017

### Enhancements

* Improves error handing for exchange rates and conversions in the case where either the exchange rate service is not running or there is no available rate for a given currency

* Improve the error handling related to Ecto loading, dumping and casting.  This is a more robust approach to maintaining data integrity by ensuring only valid currency codes are loaded, dumped or casted.

### Bug Fixes

* Bump `ex_cldr` dependency to version 0.1.2.  This fixes the issue where the atoms representing value currency codes would not be loaded early enough to be available for `known_locale?/1`

## Changelog for Ex_Money v0.1.0 April 8, 2017

Minor version is bumped to reflect the change in behaviour of `Money.new/2` which now returns an error tuple if the currency code is invalid rather than raising an exception.

### Enhancements

* `Money.new/2` now returns an error tuple of the form `{:error, {exception, message}}` if the currency code is invalid rather than the old behaviour of raising an exception.

* `Money.new!/2` is added that provides the previous default behaviour of raising an exception if the currency code is invalid.

* Depends on `ex_cldr` at version 0.1.1 which provides enhanced currency code validation checking that allows duplicate code in `ex_money` to be removed.

## Changelog for Ex_Money v0.0.16 April 7, 2017

### Bug Fixes

* Fixes the case where an example of `Money.new("USD", 100)` could fail because the list of `atom` currency codes had not been loaded.  The list is now force-loaded at compile time.

## Changelog for Ex_Money v0.0.15 March 23, 2017

### Enhancements

* Bump `ex_cldr` dependency version to 0.1.0 which includes CLDR repository version 31.0.0

## Changelog for Ex_Money v0.0.14 February 27, 2017

### Bugfixes

* Bump dependency requirement for `ex_cldr` to at least 0.0.20 since 0.0.19 omits `version.json`

## Changelog for Ex_Money v0.0.13 February 21, 2017

### Enhancements

* Adds a alternative type `Money.Ecto.Map.Type` to support serializing `%Money{}` types to databases that do not support composite types but do support Ecto map types.

* Renamed `Money.Ecto.Type` to `Money.Ecto.Composite.Type` to more clearly reflect the underlying implementation and to differentiate from the new map type implementation.

* Renamed the migration task that creates the composite type in Postgres to `Money.Gen.Postgres.Migration` since it is only applicable to Postgres.

* Supports `cast`ing maps that have both "currency" and "amount" keys into Ecto changesets which is helpful for pattern matching and changesets.

## Changelog for Ex_Money v0.0.12 February 20, 2017

### Enhancements

* Updates `Ecto` dependency to `~> 2.1`

### Bugfixes

* Updates `ex_cldr` dependency to v0.0.18 which fixes pluralization of `%Decimal{}` types

## Changelog for Ex_Money v0.0.11 December 12, 2016

### Enhancements

* `:exchange_rate_service` is false by default.  This is a change from previous releases that configured the service on by default

* Removed dependency on HTTPoison, uses the built-in `:httpc` module instead since the requirements are simple

### Bugfixes

* Updates ex_cldr to v0.0.15 which fixes error in Financial.periods()

* `:open_exchange_rates_app_id` is not long reqired to be specified  in order for compilation to complete

* declares Ecto as an optional dependency which should fix the compilation order and therefore result in the ecto migration Mix task and the Ecto type to be available after installation without a forced recompile/

## Changelog for Ex_Money v0.0.10 December 11, 2016

### Bugfixes

* Update dependency for :ex_cldr to v0.0.13 since v0.0.12 was preventing compilation when Plug was loaded

## Changelog for Ex_Money v0.0.7 November 23, 2016

### Enhancements

* Add optional callback module that defines a `rates_retrieved/2` function that is invoked on each successful retrieval of exchange rates

## Changelog for Ex_Money v0.0.6 November 21, 2016

### Enhancements

* Add present_value and future_value for a list of cash flows

* Add net_present_value for an investment and a list of cash flows

* Add net_present_value for an investment, payment, interest rate and periods

* Add internal_rate_of_return for a list of cash flows

* Add exchange rate retrieval and currency conversion support

## Changelog for Ex_Money v0.0.5 October 8, 2016

### Enhancements

* Adds a set of financial functions defined in `Money.Financial`

* Adds a sigil `~M` defined in `Money.Sigil`

* Adds the `Phoenix.HTML.Safe` protocol implementation

## Changelog for Ex_Money v0.0.4 October 8, 2016

### Bug Fixes

* Removed ambiguous and unhelpful function Money.rounding/0

### Enhancements

* Added usage examples and doctests

* Improved documentation in several places to make the intent clearer

* Made the SQL in the migration clearer for the output when the migration is run


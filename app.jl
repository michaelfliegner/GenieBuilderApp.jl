module App

using GenieFramework
using BitemporalPostgres, JSON, LifeInsuranceDataModel, LifeInsuranceProduct, TimeZones, ToStruct
@genietools
selected
@handlers begin
  @out activetxn::Integer = 0
  @in command::String = ""
  @out contracts::Vector{Contract} = []
  @out current_contract::Contract = Contract()
  @in selected_contract_idx::Integer = -1
  @in selected_contractpartner_idx::Integer = -1
  @in selected_productitem_idx::Integer = -1
  @in selected_version::String = ""
  @out current_version::Integer = 0
  @out txn_time::ZonedDateTime = now(tz"Africa/Porto-Novo")
  @out ref_time::ZonedDateTime = now(tz"Africa/Porto-Novo")
  @out histo::Vector{Dict{String,Any}} = Dict{String,Any}[]
  @in cs::Dict{String,Any} = Dict{String,Any}(
    "tsdb_validfrom" => "2022-10-14T12:31:04.754+00:00",
    "ref_history" => Dict{String,Any}("value" => 9),
    "revision" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 12), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "ref_component" => Dict{String,Any}("value" => 1), "id" => Dict{String,Any}("value" => 5), "description" => "contract 1, 4th mutation"),
    "partner_refs" => Any[Dict{String,Any}("selected" => false, "rev" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 9), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "ref_partner" => Dict{String,Any}("value" => 1), "ref_component" => Dict{String,Any}("value" => 1), "id" => Dict{String,Any}("value" => 1), "ref_role" => Dict{String,Any}("value" => 1), "description" => "policiyholder ref properties"), "ref" => Dict{String,Any}("tsdb_validfrom" => "2022-10-14T12:31:03.997+00:00", "ref_history" => Dict{String,Any}("value" => 9007199254740991), "revision" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 1), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "date_of_birth" => "2000-01-01", "ref_component" => Dict{String,Any}("value" => 1), "id" => Dict{String,Any}("value" => 1), "description" => "Partner 1"), "ref_version" => Dict{String,Any}("value" => 9007199254740991), "tsw_validfrom" => "2022-10-14T12:31:03.997+00:00"))],
    "ref_entities" => Dict{String,Any}(),
    "ref_version" => Dict{String,Any}("value" => 12),
    "tsw_validfrom" => "2022-10-14T12:31:04.754+00:00",
    "product_items" => Any[
      Dict{String,Any}(
        "tariff_items" => Any[
          Dict{String,Any}("tariff_ref" => Dict{String,Any}("rev" => Dict{String,Any}("ref_tariff" => Dict{String,Any}("value" => 1), "id" => Dict{String,Any}("value" => 1), "deferment" => 0, "annuity_due" => 0.0, "description" => "Main Coverage - Life", "ref_validfrom" => Dict{String,Any}("value" => 9), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "ref_component" => Dict{String,Any}("value" => 1), "net_premium" => 0.0, "ref_role" => Dict{String,Any}("value" => 1), "annuity_immediate" => 0.0), "ref" => Dict{String,Any}("tsdb_validfrom" => "2022-10-14T12:31:04.040+00:00", "ref_history" => Dict{String,Any}("value" => 9007199254740991), "revision" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 2), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "mortality_table" => "1980 CET - Male Nonsmoker, ANB", "ref_component" => Dict{String,Any}("value" => 1), "id" => Dict{String,Any}("value" => 1), "description" => "Life Risk Insurance"), "ref_version" => Dict{String,Any}("value" => 9007199254740991), "tsw_validfrom" => "2022-10-14T12:31:04.040+00:00")), "partner_refs" => Any[Dict{String,Any}("rev" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 9), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "ref_partner" => Dict{String,Any}("value" => 1), "ref_component" => Dict{String,Any}("value" => 1), "id" => Dict{String,Any}("value" => 1), "ref_role" => Dict{String,Any}("value" => 1), "description" => ""), "ref" => Dict{String,Any}("tsdb_validfrom" => "2022-10-14T12:31:04.074+00:00", "ref_history" => Dict{String,Any}("value" => 9007199254740991), "revision" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 1), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "date_of_birth" => "2000-01-01", "ref_component" => Dict{String,Any}("value" => 1), "id" => Dict{String,Any}("value" => 1), "description" => "Partner 1"), "ref_version" => Dict{String,Any}("value" => 9007199254740991), "tsw_validfrom" => "2022-10-14T12:31:04.074+00:00")), Dict{String,Any}("rev" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 9), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "ref_partner" => Dict{String,Any}("value" => 1), "ref_component" => Dict{String,Any}("value" => 2), "id" => Dict{String,Any}("value" => 2), "ref_role" => Dict{String,Any}("value" => 1), "description" => ""), "ref" => Dict{String,Any}("tsdb_validfrom" => "2022-10-14T12:31:04.099+00:00", "ref_history" => Dict{String,Any}("value" => 9007199254740991), "revision" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 1), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "date_of_birth" => "2000-01-01", "ref_component" => Dict{String,Any}("value" => 1), "id" => Dict{String,Any}("value" => 1), "description" => "Partner 1"), "ref_version" => Dict{String,Any}("value" => 9007199254740991), "tsw_validfrom" => "2022-10-14T12:31:04.099+00:00")), Dict{String,Any}("rev" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 9), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "ref_partner" => Dict{String,Any}("value" => 1), "ref_component" => Dict{String,Any}("value" => 3), "id" => Dict{String,Any}("value" => 3), "ref_role" => Dict{String,Any}("value" => 1), "description" => ""), "ref" => Dict{String,Any}("tsdb_validfrom" => "2022-10-14T12:31:04.129+00:00", "ref_history" => Dict{String,Any}("value" => 9007199254740991), "revision" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 1), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "date_of_birth" => "2000-01-01", "ref_component" => Dict{String,Any}("value" => 1), "id" => Dict{String,Any}("value" => 1), "description" => "Partner 1"), "ref_version" => Dict{String,Any}("value" => 9007199254740991), "tsw_validfrom" => "2022-10-14T12:31:04.129+00:00")), Dict{String,Any}("rev" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 9), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "ref_partner" => Dict{String,Any}("value" => 1), "ref_component" => Dict{String,Any}("value" => 4), "id" => Dict{String,Any}("value" => 4), "ref_role" => Dict{String,Any}("value" => 1), "description" => ""), "ref" => Dict{String,Any}("tsdb_validfrom" => "2022-10-14T12:31:04.161+00:00", "ref_history" => Dict{String,Any}("value" => 9007199254740991), "revision" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 1), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "date_of_birth" => "2000-01-01", "ref_component" => Dict{String,Any}("value" => 1), "id" => Dict{String,Any}("value" => 1), "description" => "Partner 1"), "ref_version" => Dict{String,Any}("value" => 9007199254740991), "tsw_validfrom" => "2022-10-14T12:31:04.161+00:00")), Dict{String,Any}("rev" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 9), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "ref_partner" => Dict{String,Any}("value" => 1), "ref_component" => Dict{String,Any}("value" => 5), "id" => Dict{String,Any}("value" => 5), "ref_role" => Dict{String,Any}("value" => 1), "description" => ""), "ref" => Dict{String,Any}("tsdb_validfrom" => "2022-10-14T12:31:04.192+00:00", "ref_history" => Dict{String,Any}("value" => 9007199254740991), "revision" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 1), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "date_of_birth" => "2000-01-01", "ref_component" => Dict{String,Any}("value" => 1), "id" => Dict{String,Any}("value" => 1), "description" => "Partner 1"), "ref_version" => Dict{String,Any}("value" => 9007199254740991), "tsw_validfrom" => "2022-10-14T12:31:04.192+00:00")), Dict{String,Any}("rev" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 9), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "ref_partner" => Dict{String,Any}("value" => 1), "ref_component" => Dict{String,Any}("value" => 6), "id" => Dict{String,Any}("value" => 6), "ref_role" => Dict{String,Any}("value" => 1), "description" => ""), "ref" => Dict{String,Any}("tsdb_validfrom" => "2022-10-14T12:31:04.223+00:00", "ref_history" => Dict{String,Any}("value" => 9007199254740991), "revision" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 1), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "date_of_birth" => "2000-01-01", "ref_component" => Dict{String,Any}("value" => 1), "id" => Dict{String,Any}("value" => 1), "description" => "Partner 1"), "ref_version" => Dict{String,Any}("value" => 9007199254740991), "tsw_validfrom" => "2022-10-14T12:31:04.223+00:00"))]),
          Dict{String,Any}("tariff_ref" => Dict{String,Any}("rev" => Dict{String,Any}("ref_tariff" => Dict{String,Any}("value" => 4), "id" => Dict{String,Any}("value" => 2), "deferment" => 0, "annuity_due" => 0.0, "description" => "Profit participation Life Risk", "ref_validfrom" => Dict{String,Any}("value" => 9), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "ref_component" => Dict{String,Any}("value" => 2), "net_premium" => 0.0, "ref_role" => Dict{String,Any}("value" => 4), "annuity_immediate" => 0.0), "ref" => Dict{String,Any}("tsdb_validfrom" => "2022-10-14T12:31:04.248+00:00", "ref_history" => Dict{String,Any}("value" => 9007199254740991), "revision" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 5), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "mortality_table" => "2001 VBT Residual Standard Select and Ultimate - Male Nonsmoker, ANB", "ref_component" => Dict{String,Any}("value" => 4), "id" => Dict{String,Any}("value" => 4), "description" => "Profit participation"), "ref_version" => Dict{String,Any}("value" => 9007199254740991), "tsw_validfrom" => "2022-10-14T12:31:04.248+00:00")), "partner_refs" => Any[Dict{String,Any}("rev" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 12), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "ref_partner" => Dict{String,Any}("value" => 1), "ref_component" => Dict{String,Any}("value" => 7), "id" => Dict{String,Any}("value" => 7), "ref_role" => Dict{String,Any}("value" => 1), "description" => ""), "ref" => Dict{String,Any}("tsdb_validfrom" => "2022-10-14T12:31:04.283+00:00", "ref_history" => Dict{String,Any}("value" => 9007199254740991), "revision" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 1), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "date_of_birth" => "2000-01-01", "ref_component" => Dict{String,Any}("value" => 1), "id" => Dict{String,Any}("value" => 1), "description" => "Partner 1"), "ref_version" => Dict{String,Any}("value" => 9007199254740991), "tsw_validfrom" => "2022-10-14T12:31:04.283+00:00")), Dict{String,Any}("rev" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 12), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "ref_partner" => Dict{String,Any}("value" => 1), "ref_component" => Dict{String,Any}("value" => 8), "id" => Dict{String,Any}("value" => 8), "ref_role" => Dict{String,Any}("value" => 1), "description" => ""), "ref" => Dict{String,Any}("tsdb_validfrom" => "2022-10-14T12:31:04.308+00:00", "ref_history" => Dict{String,Any}("value" => 9007199254740991), "revision" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 1), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "date_of_birth" => "2000-01-01", "ref_component" => Dict{String,Any}("value" => 1), "id" => Dict{String,Any}("value" => 1), "description" => "Partner 1"), "ref_version" => Dict{String,Any}("value" => 9007199254740991), "tsw_validfrom" => "2022-10-14T12:31:04.308+00:00")), Dict{String,Any}("rev" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 12), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "ref_partner" => Dict{String,Any}("value" => 1), "ref_component" => Dict{String,Any}("value" => 9), "id" => Dict{String,Any}("value" => 9), "ref_role" => Dict{String,Any}("value" => 1), "description" => ""), "ref" => Dict{String,Any}("tsdb_validfrom" => "2022-10-14T12:31:04.340+00:00", "ref_history" => Dict{String,Any}("value" => 9007199254740991), "revision" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 1), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "date_of_birth" => "2000-01-01", "ref_component" => Dict{String,Any}("value" => 1), "id" => Dict{String,Any}("value" => 1), "description" => "Partner 1"), "ref_version" => Dict{String,Any}("value" => 9007199254740991), "tsw_validfrom" => "2022-10-14T12:31:04.340+00:00")), Dict{String,Any}("rev" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 12), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "ref_partner" => Dict{String,Any}("value" => 1), "ref_component" => Dict{String,Any}("value" => 10), "id" => Dict{String,Any}("value" => 10), "ref_role" => Dict{String,Any}("value" => 1), "description" => ""), "ref" => Dict{String,Any}("tsdb_validfrom" => "2022-10-14T12:31:04.368+00:00", "ref_history" => Dict{String,Any}("value" => 9007199254740991), "revision" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 1), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "date_of_birth" => "2000-01-01", "ref_component" => Dict{String,Any}("value" => 1), "id" => Dict{String,Any}("value" => 1), "description" => "Partner 1"), "ref_version" => Dict{String,Any}("value" => 9007199254740991), "tsw_validfrom" => "2022-10-14T12:31:04.368+00:00")), Dict{String,Any}("rev" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 12), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "ref_partner" => Dict{String,Any}("value" => 1), "ref_component" => Dict{String,Any}("value" => 11), "id" => Dict{String,Any}("value" => 11), "ref_role" => Dict{String,Any}("value" => 1), "description" => ""), "ref" => Dict{String,Any}("tsdb_validfrom" => "2022-10-14T12:31:04.396+00:00", "ref_history" => Dict{String,Any}("value" => 9007199254740991), "revision" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 1), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "date_of_birth" => "2000-01-01", "ref_component" => Dict{String,Any}("value" => 1), "id" => Dict{String,Any}("value" => 1), "description" => "Partner 1"), "ref_version" => Dict{String,Any}("value" => 9007199254740991), "tsw_validfrom" => "2022-10-14T12:31:04.396+00:00")), Dict{String,Any}("rev" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 12), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "ref_partner" => Dict{String,Any}("value" => 1), "ref_component" => Dict{String,Any}("value" => 12), "id" => Dict{String,Any}("value" => 12), "ref_role" => Dict{String,Any}("value" => 1), "description" => ""), "ref" => Dict{String,Any}("tsdb_validfrom" => "2022-10-14T12:31:04.425+00:00", "ref_history" => Dict{String,Any}("value" => 9007199254740991), "revision" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 1), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "date_of_birth" => "2000-01-01", "ref_component" => Dict{String,Any}("value" => 1), "id" => Dict{String,Any}("value" => 1), "description" => "Partner 1"), "ref_version" => Dict{String,Any}("value" => 9007199254740991), "tsw_validfrom" => "2022-10-14T12:31:04.425+00:00"))]),
          Dict{String,Any}("tariff_ref" => Dict{String,Any}("rev" => Dict{String,Any}("ref_tariff" => Dict{String,Any}("value" => 2), "id" => Dict{String,Any}("value" => 3), "deferment" => 0, "annuity_due" => 0.0, "description" => "additional cover Terminal Illness", "ref_validfrom" => Dict{String,Any}("value" => 9), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "ref_component" => Dict{String,Any}("value" => 3), "net_premium" => 0.0, "ref_role" => Dict{String,Any}("value" => 3), "annuity_immediate" => 0.0), "ref" => Dict{String,Any}("tsdb_validfrom" => "2022-10-14T12:31:04.452+00:00", "ref_history" => Dict{String,Any}("value" => 9007199254740991), "revision" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 3), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "mortality_table" => "2001 VBT Residual Standard Select and Ultimate - Male Nonsmoker, ANB", "ref_component" => Dict{String,Any}("value" => 2), "id" => Dict{String,Any}("value" => 2), "description" => "Terminal Illness"), "ref_version" => Dict{String,Any}("value" => 9007199254740991), "tsw_validfrom" => "2022-10-14T12:31:04.452+00:00")), "partner_refs" => Any[]),
          Dict{String,Any}("tariff_ref" => Dict{String,Any}("rev" => Dict{String,Any}("ref_tariff" => Dict{String,Any}("value" => 4), "id" => Dict{String,Any}("value" => 4), "deferment" => 0, "annuity_due" => 0.0, "description" => "Profit participation Terminal Illness", "ref_validfrom" => Dict{String,Any}("value" => 9), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "ref_component" => Dict{String,Any}("value" => 4), "net_premium" => 0.0, "ref_role" => Dict{String,Any}("value" => 4), "annuity_immediate" => 0.0), "ref" => Dict{String,Any}("tsdb_validfrom" => "2022-10-14T12:31:04.486+00:00", "ref_history" => Dict{String,Any}("value" => 9007199254740991), "revision" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 5), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "mortality_table" => "2001 VBT Residual Standard Select and Ultimate - Male Nonsmoker, ANB", "ref_component" => Dict{String,Any}("value" => 4), "id" => Dict{String,Any}("value" => 4), "description" => "Profit participation"), "ref_version" => Dict{String,Any}("value" => 9007199254740991), "tsw_validfrom" => "2022-10-14T12:31:04.486+00:00")), "partner_refs" => Any[]),
          Dict{String,Any}("tariff_ref" => Dict{String,Any}("rev" => Dict{String,Any}("ref_tariff" => Dict{String,Any}("value" => 3), "id" => Dict{String,Any}("value" => 5), "deferment" => 0, "annuity_due" => 0.0, "description" => "additional cover Occupational Disablity", "ref_validfrom" => Dict{String,Any}("value" => 9), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "ref_component" => Dict{String,Any}("value" => 5), "net_premium" => 0.0, "ref_role" => Dict{String,Any}("value" => 2), "annuity_immediate" => 0.0), "ref" => Dict{String,Any}("tsdb_validfrom" => "2022-10-14T12:31:04.516+00:00", "ref_history" => Dict{String,Any}("value" => 9007199254740991), "revision" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 4), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "mortality_table" => "2001 VBT Residual Standard Select and Ultimate - Male Nonsmoker, ANB", "ref_component" => Dict{String,Any}("value" => 3), "id" => Dict{String,Any}("value" => 3), "description" => "Occupational Disability"), "ref_version" => Dict{String,Any}("value" => 9007199254740991), "tsw_validfrom" => "2022-10-14T12:31:04.516+00:00")), "partner_refs" => Any[]),
          Dict{String,Any}("tariff_ref" => Dict{String,Any}("rev" => Dict{String,Any}("ref_tariff" => Dict{String,Any}("value" => 4), "id" => Dict{String,Any}("value" => 6), "deferment" => 0, "annuity_due" => 0.0, "description" => "Profit participation Occ.Disablity", "ref_validfrom" => Dict{String,Any}("value" => 9), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "ref_component" => Dict{String,Any}("value" => 6), "net_premium" => 0.0, "ref_role" => Dict{String,Any}("value" => 4), "annuity_immediate" => 0.0), "ref" => Dict{String,Any}("tsdb_validfrom" => "2022-10-14T12:31:04.547+00:00", "ref_history" => Dict{String,Any}("value" => 9007199254740991), "revision" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 5), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "mortality_table" => "2001 VBT Residual Standard Select and Ultimate - Male Nonsmoker, ANB", "ref_component" => Dict{String,Any}("value" => 4), "id" => Dict{String,Any}("value" => 4), "description" => "Profit participation"), "ref_version" => Dict{String,Any}("value" => 9007199254740991), "tsw_validfrom" => "2022-10-14T12:31:04.547+00:00")), "partner_refs" => Any[])
        ],
        "revision" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 9), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "ref_component" => Dict{String,Any}("value" => 1), "id" => Dict{String,Any}("value" => 1), "position" => 1, "description" => "from contract creation", "ref_product" => Dict{String,Any}("value" => 2))
      ),
      Dict{String,Any}("tariff_items" => Any[Dict{String,Any}("tariff_ref" => Dict{String,Any}("rev" => Dict{String,Any}("ref_tariff" => Dict{String,Any}("value" => 1), "id" => Dict{String,Any}("value" => 7), "deferment" => 0, "annuity_due" => 0.0, "description" => "Main Coverage - Life", "ref_validfrom" => Dict{String,Any}("value" => 12), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "ref_component" => Dict{String,Any}("value" => 7), "net_premium" => 0.0, "ref_role" => Dict{String,Any}("value" => 1), "annuity_immediate" => 0.0), "ref" => Dict{String,Any}("tsdb_validfrom" => "2022-10-14T12:31:04.593+00:00", "ref_history" => Dict{String,Any}("value" => 9007199254740991), "revision" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 2), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "mortality_table" => "1980 CET - Male Nonsmoker, ANB", "ref_component" => Dict{String,Any}("value" => 1), "id" => Dict{String,Any}("value" => 1), "description" => "Life Risk Insurance"), "ref_version" => Dict{String,Any}("value" => 9007199254740991), "tsw_validfrom" => "2022-10-14T12:31:04.593+00:00")), "partner_refs" => Any[]), Dict{String,Any}("tariff_ref" => Dict{String,Any}("rev" => Dict{String,Any}("ref_tariff" => Dict{String,Any}("value" => 4), "id" => Dict{String,Any}("value" => 8), "deferment" => 0, "annuity_due" => 0.0, "description" => "Profit participation Life Risk", "ref_validfrom" => Dict{String,Any}("value" => 12), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "ref_component" => Dict{String,Any}("value" => 8), "net_premium" => 0.0, "ref_role" => Dict{String,Any}("value" => 4), "annuity_immediate" => 0.0), "ref" => Dict{String,Any}("tsdb_validfrom" => "2022-10-14T12:31:04.624+00:00", "ref_history" => Dict{String,Any}("value" => 9007199254740991), "revision" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 5), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "mortality_table" => "2001 VBT Residual Standard Select and Ultimate - Male Nonsmoker, ANB", "ref_component" => Dict{String,Any}("value" => 4), "id" => Dict{String,Any}("value" => 4), "description" => "Profit participation"), "ref_version" => Dict{String,Any}("value" => 9007199254740991), "tsw_validfrom" => "2022-10-14T12:31:04.624+00:00")), "partner_refs" => Any[]), Dict{String,Any}("tariff_ref" => Dict{String,Any}("rev" => Dict{String,Any}("ref_tariff" => Dict{String,Any}("value" => 2), "id" => Dict{String,Any}("value" => 9), "deferment" => 0, "annuity_due" => 0.0, "description" => "additional cover Terminal Illness", "ref_validfrom" => Dict{String,Any}("value" => 12), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "ref_component" => Dict{String,Any}("value" => 9), "net_premium" => 0.0, "ref_role" => Dict{String,Any}("value" => 3), "annuity_immediate" => 0.0), "ref" => Dict{String,Any}("tsdb_validfrom" => "2022-10-14T12:31:04.658+00:00", "ref_history" => Dict{String,Any}("value" => 9007199254740991), "revision" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 3), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "mortality_table" => "2001 VBT Residual Standard Select and Ultimate - Male Nonsmoker, ANB", "ref_component" => Dict{String,Any}("value" => 2), "id" => Dict{String,Any}("value" => 2), "description" => "Terminal Illness"), "ref_version" => Dict{String,Any}("value" => 9007199254740991), "tsw_validfrom" => "2022-10-14T12:31:04.658+00:00")), "partner_refs" => Any[]), Dict{String,Any}("tariff_ref" => Dict{String,Any}("rev" => Dict{String,Any}("ref_tariff" => Dict{String,Any}("value" => 4), "id" => Dict{String,Any}("value" => 10), "deferment" => 0, "annuity_due" => 0.0, "description" => "Profit participation Terminal Illness", "ref_validfrom" => Dict{String,Any}("value" => 12), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "ref_component" => Dict{String,Any}("value" => 10), "net_premium" => 0.0, "ref_role" => Dict{String,Any}("value" => 4), "annuity_immediate" => 0.0), "ref" => Dict{String,Any}("tsdb_validfrom" => "2022-10-14T12:31:04.693+00:00", "ref_history" => Dict{String,Any}("value" => 9007199254740991), "revision" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 5), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "mortality_table" => "2001 VBT Residual Standard Select and Ultimate - Male Nonsmoker, ANB", "ref_component" => Dict{String,Any}("value" => 4), "id" => Dict{String,Any}("value" => 4), "description" => "Profit participation"), "ref_version" => Dict{String,Any}("value" => 9007199254740991), "tsw_validfrom" => "2022-10-14T12:31:04.693+00:00")), "partner_refs" => Any[]), Dict{String,Any}("tariff_ref" => Dict{String,Any}("rev" => Dict{String,Any}("ref_tariff" => Dict{String,Any}("value" => 3), "id" => Dict{String,Any}("value" => 11), "deferment" => 0, "annuity_due" => 0.0, "description" => "additional cover Occupational Disablity", "ref_validfrom" => Dict{String,Any}("value" => 12), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "ref_component" => Dict{String,Any}("value" => 11), "net_premium" => 0.0, "ref_role" => Dict{String,Any}("value" => 2), "annuity_immediate" => 0.0), "ref" => Dict{String,Any}("tsdb_validfrom" => "2022-10-14T12:31:04.725+00:00", "ref_history" => Dict{String,Any}("value" => 9007199254740991), "revision" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 4), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "mortality_table" => "2001 VBT Residual Standard Select and Ultimate - Male Nonsmoker, ANB", "ref_component" => Dict{String,Any}("value" => 3), "id" => Dict{String,Any}("value" => 3), "description" => "Occupational Disability"), "ref_version" => Dict{String,Any}("value" => 9007199254740991), "tsw_validfrom" => "2022-10-14T12:31:04.725+00:00")), "partner_refs" => Any[]), Dict{String,Any}("tariff_ref" => Dict{String,Any}("rev" => Dict{String,Any}("ref_tariff" => Dict{String,Any}("value" => 4), "id" => Dict{String,Any}("value" => 12), "deferment" => 0, "annuity_due" => 0.0, "description" => "Profit participation Occ.Disablity", "ref_validfrom" => Dict{String,Any}("value" => 12), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "ref_component" => Dict{String,Any}("value" => 12), "net_premium" => 0.0, "ref_role" => Dict{String,Any}("value" => 4), "annuity_immediate" => 0.0), "ref" => Dict{String,Any}("tsdb_validfrom" => "2022-10-14T12:31:04.751+00:00", "ref_history" => Dict{String,Any}("value" => 9007199254740991), "revision" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 5), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "mortality_table" => "2001 VBT Residual Standard Select and Ultimate - Male Nonsmoker, ANB", "ref_component" => Dict{String,Any}("value" => 4), "id" => Dict{String,Any}("value" => 4), "description" => "Profit participation"), "ref_version" => Dict{String,Any}("value" => 9007199254740991), "tsw_validfrom" => "2022-10-14T12:31:04.751+00:00")), "partner_refs" => Any[])], "revision" => Dict{String,Any}("ref_validfrom" => Dict{String,Any}("value" => 12), "ref_invalidfrom" => Dict{String,Any}("value" => 9007199254740991), "ref_component" => Dict{String,Any}("value" => 2), "id" => Dict{String,Any}("value" => 2), "position" => 2, "description" => "from contract 4th mutation", "ref_product" => Dict{String,Any}("value" => 2)))
    ]
  )
  @out prs::Dict{String,Any} = Dict{String,Any}("loaded" => "false")
  @in selected_product_part_idx::Integer = 0
  @in tab::String = "csection"
  @in leftDrawerOpen::Bool = false
  @in show_contract_partners::Bool = false
  @in show_product_items::Bool = false
  @in selected_product::Integer = 0
  @in show_tariff_item_partners::Bool = false
  @in show_tariff_items::Bool = false
  @out rolesContractPartner::Dict{Integer,String} = Dict{Integer,String}()
  @out rolesTariffItem::Dict{Integer,String} = Dict{Integer,String}()
  @out rolesTariffItemPartner::Dict{Integer,String} = Dict{Integer,String}()


  @onchange isready begin
    @show "App is loaded"
    contracts = LifeInsuranceDataModel.get_contracts()
    tab = "contracts"
    cs["loaded"] = "false"
    prs = Dict{String,Any}("loaded" => "false")
    @show "contractsModel pushed"
  end

  @onchange selected_contract_idx begin
    if (selected_contract_idx >= 0)
      @show "selected_contract_idx"
      @show selected_contract_idx
      @info "enter selected_contract_idx"
      try
        current_contract = contracts[selected_contract_idx+1]
        histo = map(convert, LifeInsuranceDataModel.history_forest(current_contract.ref_history.value).shadowed)
        cs = JSON.parse(JSON.json(LifeInsuranceDataModel.csection(current_contract.id.value, now(tz"Europe/Warsaw"), now(tz"Europe/Warsaw"), activetxn)))
        cs["loaded"] = "true"
        ti = cs["product_items"][1]["tariff_items"][1]
        print("ti=")
        println(ti)
        print("tistruct")
        println(ToStruct.tostruct(LifeInsuranceDataModel.TariffItemSection, ti))
        tistruct = ToStruct.tostruct(LifeInsuranceDataModel.TariffItemSection, ti)
        LifeInsuranceProduct.calculate!(tistruct)
        cs["product_items"][1]["tariff_items"][1] = JSON.parse(JSON.json(tistruct))
        selected_contract_idx = -1
        tab = "csection"
        @show cs["loaded"]
      catch err
        println("wassis shief gegangen ")
        @error "ERROR: " exception = (err, catch_backtrace())
      end
    end
  end

  @onchange selected_contractpartner_idx begin
    if selected_contractpartner_idx != -1
      @show selected_contractpartner_idx
      selected_contractpartner_idx = -1
    end
  end

  @onchange selected_productitem_idx begin
    if selected_productitem_idx != -1
      @show selected_productitem_idx
      selected_productitem_idx = -1
    end
  end

  @onchange command begin
    if command == "add productitem"
      @show command
      command = ""
    end
    if command == "add contractpartner"
      @show command
      command = ""
    end
  end

  @onchange selected_version begin
    @info "version handler"
    @show selected_version
    if selected_version != ""
      try
        node = fn(histo, selected_version)
        println(node)
        txn_time = node["interval"]["tsdb_validfrom"]
        ref_time = node["interval"]["tsworld_validfrom"]
        current_version = parse(Int, selected_version)
        @show txn_time
        @show ref_time
        @show current_version
        @info "vor csection"
        cs = JSON.parse(JSON.json(LifeInsuranceDataModel.csection(current_contract.id.value, txn_time, ref_time)))
        cs["loaded"] = "true"
        @info "vor tab "
        tab = "csection"
        ti = LifeInsuranceProduct.calculate!(cs["product_items"][1].tariff_items[1])
        print("ti=")
        println(ti)
      catch err
        println("wassis shief gegangen ")
        @error "ERROR: " exception = (err, catch_backtrace())
      end
    end

  end
end

"""
convert(node::BitemporalPostgres.Node)::Dict{String,Any}

provides the view for the history forest from tree data the contracts/partnersModel delivers
"""
function convert(node::BitemporalPostgres.Node)::Dict{String,Any}
  i = Dict(string(fn) => getfield(getfield(node, :interval), fn) for fn in fieldnames(ValidityInterval))
  shdw = length(node.shadowed) == 0 ? [] : map(node.shadowed) do child
    convert(child)
  end
  Dict("version" => string(i["ref_version"]), "interval" => i, "children" => shdw, "label" => "committed " * string(i["tsdb_validfrom"]) * " valid as of " * string(Date(i["tsworld_validfrom"], UTC)))
end


"""
fn
retrieves a history node from its label 
"""

function fn(ns::Vector{Dict{String,Any}}, lbl::String)
  for n in ns
    if (n["version"] == lbl)
      return (n)
    else
      if (length(n["children"]) > 0)
        m = fn(n["children"], lbl)
        if (typeof(m) != Nothing)
          return m
        end
      end
    end
  end
end

@page("/", "app.jl.html")

end

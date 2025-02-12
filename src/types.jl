# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Description
# ==============================================================================
#
#   Definition of types and structures.
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

const SearchMatch = NTuple{3, Int}
const SearchMatches = Vector{SearchMatch}

# Structure that holds all the information about the pager.
Base.@kwdef mutable struct Pager
    term::REPL.Terminals.TTYTerminal
    buf::IOContext{IOBuffer}
    display_size::NTuple{2, Int} = (0, 0)
    start_row::Int = 1
    start_col::Int = 1
    lines::Vector{String} = String[]
    num_lines::Int = 0
    lines_cropped::Int = 0
    columns_cropped::Int = 0
    search_matches::SearchMatches = SearchMatch[]
    active_search_match_id::Int = 0
    redraw::Bool = true
    mode::Symbol = :view
    event::Union{Nothing, Symbol} = nothing
    features::Vector{Symbol} = Symbol[]
    freeze_columns::Int = 0
    freeze_rows::Int = 0
    title_rows::Int = 0
    draw_ruler::Bool = false
end

# This struct describe the decoration of a string.
Base.@kwdef struct Decoration
    foreground::String = ""
    background::String = ""
    bold::Bool         = false
    underline::Bool    = false
    reset::Bool        = false
    reversed::Bool     = false

    # This variable is used to force a formatting. This is necessary because we
    # do not add escape sequences if the decoration is the default, avoiding
    # unnecessary writing. However, we need to differentiate the decoration
    # that is forcing to go back to the default.
    force::Bool = false
end

"""
    struct Keystorke

Structure that defines a keystroke.

# Fields

* `raw`: Raw keystroke code converted to string.
* `value`: String representing the keystroke.
* `alt`: `true` if ALT key was pressed (only valid if `value != :char`).
* `ctrl`: `true` if CTRL key was pressed (only valid if `value != :char`).
* `shift`: `true` if SHIFT key was pressed (only valid if `value != :char`).

"""
Base.@kwdef struct Keystroke
    raw::String = ""
    value::Union{Symbol, String}
    alt::Bool   = false
    ctrl::Bool  = false
    shift::Bool = false
end


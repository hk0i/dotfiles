import re

def find_indentation(string, default_size=2):
    """ finds the current line indentation """
    indentation = ""
    indent_match = re.match("\s*", string)
    if indent_match:
        indentation = indent_match.group(0)
    return indentation



# [\w\d]+ represents a valid identifier
parameter_regex = r"([\w\d]+:\s*[\w\d]+)"
parameter_finder = re.compile(parameter_regex)
find_parameters = parameter_finder.findall

function_name_regex = r"([\w\d\s\.]+\s*)\("
function_finder = re.compile(function_name_regex)
find_function_name = function_finder.search

# captures single line comments
# single_line_comment_regex = r"//\s*([\w\d]+)"
# single_line_comment_finder = re.compile(single_line_comment_finder)

# second part .+ ... adds a way to pull out trailing comments
var_declare_regex = r"\s*(let|var) ([\w\d]+):"
var_declare_finder = re.compile(var_declare_regex)
find_var_declare = var_declare_finder.search


def indentation(captured, default_size=2):
    """ returns proper indentation depending on captured string """
    if len(captured) == 0:
        return " " * default_size

    return captured


def indent(string, times=1, default_size=2):
    indent = ' ' * default_size * times
    return f'{indent}{string}'

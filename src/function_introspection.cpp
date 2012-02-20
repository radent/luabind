/**
    @file
    @brief Implementation

    @date 2012

    @author
    Ryan Pavlik
    <rpavlik@iastate.edu> and <abiryan@ryand.net>
    http://academic.cleardefinition.com/
    Iowa State University Virtual Reality Applications Center
    Human-Computer Interaction Graduate Program
*/

//          Copyright Iowa State University 2012.
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF
// ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
// TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
// PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
// SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
// ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
// ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
// OR OTHER DEALINGS IN THE SOFTWARE.

// Internal Includes
#include <luabind/function_introspection.hpp>
#include <luabind/function.hpp>
#include <luabind/detail/stack_utils.hpp>

// Library/third-party includes
// - none

// Standard includes
#include <string>

namespace luabind {

namespace {
    detail::function_object* get_function_object(argument const& fn) {
        lua_State * L = fn.interpreter();
        {
            fn.push(L);
            detail::stack_pop pop(L, 1);
            if (!detail::is_luabind_function(L, -1)) {
                return NULL;
            }
        }
        return *touserdata<detail::function_object*>(getupvalue(fn, 1));
    }

    std::string get_function_name(argument const& fn) {
        detail::function_object * f = get_function_object(fn);
        if (!f) {
            return "";
        }
        return f->name;
    }

    object get_function_overloads(argument const& fn) {
        lua_State * L = fn.interpreter();
        detail::function_object * fobj = get_function_object(fn);
        if (!fobj) {
            return object();
        }
        object overloadTable(newtable(L));
        int count = 1;
        const char * function_name = fobj->name.c_str();
        for (detail::function_object const* f = fobj; f != 0; f = f->next)
        {
            f->format_signature(L, function_name);
            detail::stack_pop pop(L, 1);
            overloadTable[count] = object(from_stack(L, -1));

            ++count;
        }
        /// @todo

        return overloadTable;
    }

}

LUABIND_API int bind_function_introspection(lua_State * L) {
    module(L, "function_info")[
        def("get_function_overloads", &get_function_overloads),
        def("get_function_name", &get_function_name)
    ];
    return 0;
}

} // end of namespace luabind
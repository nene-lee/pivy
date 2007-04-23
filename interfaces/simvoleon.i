/*
 * Copyright (c) 2002-2007 Systems in Motion
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

%define SIMVOLEON_MODULE_DOCSTRING
"The simvoleon module is a wrapper for the SIMVoleon library."
%enddef

%module(package="pivy", docstring=SIMVOLEON_MODULE_DOCSTRING) simvoleon

%{
#if defined(_WIN32) || defined(__WIN32__)
#include <windows.h>
#undef max
#undef ERROR
#undef DELETE
#undef ANY
#endif

#include <VolumeViz/C/basic.h>
#include <VolumeViz/details/SoVolumeRenderDetail.h>
#include <VolumeViz/details/SoOrthoSliceDetail.h>
#include <VolumeViz/details/SoObliqueSliceDetail.h>
#include <VolumeViz/details/SoVolumeDetail.h>
#include <VolumeViz/details/SoVolumeSkinDetail.h>
#include <VolumeViz/readers/SoVRVolFileReader.h>
#include <VolumeViz/readers/SoVolumeReader.h>
#include <VolumeViz/nodes/SoTransferFunction.h>
#include <VolumeViz/nodes/SoOrthoSlice.h>
#include <VolumeViz/nodes/SoVolumeRender.h>
#include <VolumeViz/nodes/SoVolumeRendering.h>
#include <VolumeViz/nodes/SoObliqueSlice.h>
#include <VolumeViz/nodes/SoVolumeIndexedFaceSet.h>
#include <VolumeViz/nodes/SoVolumeFaceSet.h>
#include <VolumeViz/nodes/SoVolumeData.h>
#include <VolumeViz/nodes/SoVolumeIndexedTriangleStripSet.h>
#include <VolumeViz/nodes/SoVolumeSkin.h>
#include <VolumeViz/nodes/SoVolumeTriangleStripSet.h>

#include "coin_header_includes.h"
%}

/* let SWIG handle reference counting for all SoBase derived classes */
%feature("ref") SoBase "$this->ref();"
%feature("unref") SoBase "$this->unref();"

/* include the typemaps common to all pivy modules */
%include pivy_common_typemaps.i

/* import the pivy main interface file */
%import(module="pivy") coin.i

%ignore SoVolumeData::setVolumeData(const SbVec3s &dimension, 
                                    void *data, 
                                    SoVolumeData::DataType type=SoVolumeData::UNSIGNED_BYTE, 
                                    int significantbits=0);

%extend SoVolumeData {
  void setVolumeData(SbVec3s dimension, char * data) {
    self->setVolumeData(dimension, data);
  }
}

#if 0
%typemap(in) (const SbVec3s & dimension, void * data) {
  void * data;
  PyObject * vec3s = $input;
  PyObject * buf = $input;

  if ((SWIG_ConvertPtr(vec3s, (void **)&$1, SWIGTYPE_p_SbVec3s, SWIG_POINTER_EXCEPTION | 0 )) == -1) SWIG_fail;
  if ($1 == NULL) {
    PyErr_SetString(PyExc_TypeError,"null reference"); SWIG_fail;
  }
  if (PyString_Check(buf)) {
    int len = (*$1)[0] * (*$1)[1] * ((*$1)[2] ? (*$1)[2] : 1);
    PyString_AsStringAndSize(buf, (char **)&data, &len);
    $2 = data;
  } else {
    PyErr_SetString(PyExc_TypeError, "expected a string."); SWIG_fail;
  }
}
#endif

%typemap(out) void * data = char *;
%typemap(typecheck) void * data = char *;

%include VolumeViz/details/SoVolumeRenderDetail.h
%include VolumeViz/details/SoOrthoSliceDetail.h
%include VolumeViz/details/SoObliqueSliceDetail.h
%include VolumeViz/details/SoVolumeDetail.h
%include VolumeViz/details/SoVolumeSkinDetail.h
%include VolumeViz/readers/SoVRVolFileReader.h
%include VolumeViz/readers/SoVolumeReader.h
%include VolumeViz/nodes/SoTransferFunction.h
%include VolumeViz/nodes/SoOrthoSlice.h
%include VolumeViz/nodes/SoVolumeRender.h
%include VolumeViz/nodes/SoVolumeRendering.h
%include VolumeViz/nodes/SoObliqueSlice.h
%include VolumeViz/nodes/SoVolumeIndexedFaceSet.h
%include VolumeViz/nodes/SoVolumeFaceSet.h
%include VolumeViz/nodes/SoVolumeData.h
%include VolumeViz/nodes/SoVolumeIndexedTriangleStripSet.h
%include VolumeViz/nodes/SoVolumeSkin.h
%include VolumeViz/nodes/SoVolumeTriangleStripSet.h

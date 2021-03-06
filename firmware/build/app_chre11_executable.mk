#
# Copyright (C) 2017 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LOCAL_MODULE_SUFFIX := .napp
include $(NANOHUB_APP_CONFIG)

my_variants := $(LOCAL_NANO_VARIANT_LIST)

ifeq ($(strip $(my_variants)),)
# default is to use all variants supported by this OS
my_variants := $(AUX_OS_VARIANT_LIST_$(NANO_OS))
endif

# mark the app as CHRE 1.1 nanoapp
LOCAL_NANO_APP_POSTPROCESS_FLAGS += -c 0x0101

# add app-side CHRE implementation
LOCAL_WHOLE_STATIC_LIBRARIES += \
    libnanochre11               \

# add standard libaries
LOCAL_STATIC_LIBRARIES +=       \
    libnanobuiltins             \
    libnanolibc                 \
    libnanolibm                 \

LOCAL_C_INCLUDES +=                                     \
    system/chre/chre_api/legacy/v1_1                    \

$(call for-each-variant,$(my_variants),APP,$(BUILD_NANOHUB_EXECUTABLE))

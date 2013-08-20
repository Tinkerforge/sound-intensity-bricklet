/* sound-intensity-bricklet
 * Copyright (C) 2013 Olaf Lüke <olaf@tinkerforge.com>
 *
 * sound-intensity.h: Implementation of Sound Intensity Bricklet messages
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 */

#ifndef SOUND_INTENSITY_H
#define SOUND_INTENSITY_H

#include <stdint.h>
#include "bricklib/com/com_common.h"

#define FID_GET_INTENSITY 1
#define FID_SET_INTENSITY_CALLBACK_PERIOD 2
#define FID_GET_INTENSITY_CALLBACK_PERIOD 3
#define FID_SET_INTENSITY_CALLBACK_THRESHOLD 4
#define FID_GET_INTENSITY_CALLBACK_THRESHOLD 5
#define FID_SET_DEBOUNCE_PERIOD 6
#define FID_GET_DEBOUNCE_PERIOD 7
#define FID_INTENSITY 8
#define FID_INTENSITY_REACHED 9

#define FID_LAST 7

int32_t update_intensity(const int32_t value);

void invocation(const ComType com, const uint8_t *data);
void constructor(void);
void destructor(void);
void tick(const uint8_t tick_type);

#endif

/* sound-intensity-bricklet
 * Copyright (C) 2013 Olaf Lüke <olaf@tinkerforge.com>
 *
 * sound-intensity.c: Implementation of Sound Intensity Bricklet messages
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

#include "sound-intensity.h"

#include "bricklib/bricklet/bricklet_communication.h"
#include "bricklib/utility/util_definitions.h"
#include "bricklib/drivers/adc/adc.h"
#include "brickletlib/bricklet_entry.h"
#include "brickletlib/bricklet_simple.h"
#include "config.h"

#define SIMPLE_UNIT_INTENSITY 0

const SimpleMessageProperty smp[] = {
	{SIMPLE_UNIT_INTENSITY, SIMPLE_TRANSFER_VALUE, SIMPLE_DIRECTION_GET}, // FID_GET_INTENSITY
	{SIMPLE_UNIT_INTENSITY, SIMPLE_TRANSFER_PERIOD, SIMPLE_DIRECTION_SET}, // FID_SET_INTENSITY_CALLBACK_PERIOD
	{SIMPLE_UNIT_INTENSITY, SIMPLE_TRANSFER_PERIOD, SIMPLE_DIRECTION_GET}, // FID_GET_INTENSITY_CALLBACK_PERIOD
	{SIMPLE_UNIT_INTENSITY, SIMPLE_TRANSFER_THRESHOLD, SIMPLE_DIRECTION_SET}, // FID_SET_INTENSITY_CALLBACK_THRESHOLD
	{SIMPLE_UNIT_INTENSITY, SIMPLE_TRANSFER_THRESHOLD, SIMPLE_DIRECTION_GET}, // FID_GET_INTENSITY_CALLBACK_THRESHOLD
	{0, SIMPLE_TRANSFER_DEBOUNCE, SIMPLE_DIRECTION_SET}, // FID_SET_DEBOUNCE_PERIOD
	{0, SIMPLE_TRANSFER_DEBOUNCE, SIMPLE_DIRECTION_GET}, // FID_GET_DEBOUNCE_PERIOD
};

const SimpleUnitProperty sup[] = {
	{update_intensity, SIMPLE_SIGNEDNESS_INT, FID_INTENSITY, FID_INTENSITY_REACHED, SIMPLE_UNIT_INTENSITY}, // intensity
};

const uint8_t smp_length = sizeof(smp);


void invocation(const ComType com, const uint8_t *data) {
	simple_invocation(com, data);

	if(((MessageHeader*)data)->fid > FID_LAST) {
		BA->com_return_error(data, sizeof(MessageHeader), MESSAGE_ERROR_CODE_NOT_SUPPORTED, com);
	}
}

void constructor(void) {
	_Static_assert(sizeof(BrickContext) <= BRICKLET_CONTEXT_MAX_SIZE, "BrickContext too big");

	adc_channel_enable(BS->adc_channel);
	simple_constructor();
}

void destructor(void) {
	simple_destructor();
	adc_channel_disable(BS->adc_channel);
}

int32_t update_intensity(const int32_t value) {
	// TODO: calculate intensity
	return BA->adc_channel_get_data(BS->adc_channel);
}

void tick(const uint8_t tick_type) {
	simple_tick(tick_type);
}

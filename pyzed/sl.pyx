########################################################################
#
# Copyright (c) 2017, STEREOLABS.
#
# All rights reserved.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
########################################################################

# Source file of the types Python module.

from libcpp.vector cimport vector
from libc.string cimport const_char
from libcpp.string cimport string
from libcpp.pair cimport pair
from sl_c cimport to_str, ERROR_CODE as c_ERROR_CODE, toString, sleep_ms, MODEL as c_MODEL, CAMERA_STATE as c_CAMERA_STATE, String, DeviceProperties as c_DeviceProperties, Vector2, Vector3, Vector4, Matrix3f as c_Matrix3f, Matrix4f as c_Matrix4f, UNIT as c_UNIT, COORDINATE_SYSTEM as c_COORDINATE_SYSTEM, RESOLUTION as c_RESOLUTION, VIDEO_SETTINGS as c_VIDEO_SETTINGS, DEPTH_MODE as c_DEPTH_MODE, SENSING_MODE as c_SENSING_MODE, MEASURE as c_MEASURE, VIEW as c_VIEW, TIME_REFERENCE as c_TIME_REFERENCE, POSITIONAL_TRACKING_STATE as c_POSITIONAL_TRACKING_STATE, AREA_EXPORTING_STATE as c_AREA_EXPORTING_STATE, REFERENCE_FRAME as c_REFERENCE_FRAME, SPATIAL_MAPPING_STATE as c_SPATIAL_MAPPING_STATE, SVO_COMPRESSION_MODE as c_SVO_COMPRESSION_MODE, RecordingStatus as c_RecordingStatus, getCurrentTimeStamp, Timestamp as c_Timestamp, Resolution as c_Resolution, CameraParameters as c_CameraParameters, CalibrationParameters as c_CalibrationParameters, RecordingParameters as c_RecordingParameters, CameraInformation as c_CameraInformation, MEM as c_MEM, COPY_TYPE as c_COPY_TYPE, MAT_TYPE as c_MAT_TYPE, Mat as c_Mat, Rotation as c_Rotation, Translation as c_Translation, Orientation as c_Orientation, Transform as c_Transform, uchar1, uchar2, uchar3, uchar4, float1, float2, float3, float4, matResolution, setToUchar1, setToUchar2, setToUchar3, setToUchar4, setToFloat1, setToFloat2, setToFloat3, setToFloat4, setValueUchar1, setValueUchar2, setValueUchar3, setValueUchar4, setValueFloat1, setValueFloat2, setValueFloat3, setValueFloat4, getValueUchar1, getValueUchar2, getValueUchar3, getValueUchar4, getValueFloat1, getValueFloat2, getValueFloat3, getValueFloat4, getPointerUchar1, getPointerUchar2, getPointerUchar3, getPointerUchar4, getPointerFloat1, getPointerFloat2, getPointerFloat3, getPointerFloat4, uint, MESH_FILE_FORMAT as c_MESH_FILE_FORMAT, MESH_TEXTURE_FORMAT as c_MESH_TEXTURE_FORMAT, MESH_FILTER as c_MESH_FILTER, PLANE_TYPE as c_PLANE_TYPE, MeshFilterParameters as c_MeshFilterParameters, Chunk as c_Chunk, PointCloudChunk as c_PointCloudChunk, FusedPointCloud as c_FusedPointCloud, Mesh as c_Mesh, Plane as c_Plane, CUctx_st, CUcontext, MAPPING_RESOLUTION as c_MAPPING_RESOLUTION, MAPPING_RANGE as c_MAPPING_RANGE, SPATIAL_MAP_TYPE as c_SPATIAL_MAP_TYPE, InputType as c_InputType, InitParameters as c_InitParameters, RuntimeParameters as c_RuntimeParameters, PositionalTrackingParameters as c_PositionalTrackingParameters, SpatialMappingParameters as c_SpatialMappingParameters, Pose as c_Pose, SensorsData as c_SensorsData, CAMERA_MOTION_STATE as c_CAMERA_MOTION_STATE, BarometerData as c_BarometerData, SENSOR_LOCATION as c_SENSOR_LOCATION, TemperatureData as c_TemperatureData, MagnetometerData as c_MagnetometerData, IMUData as c_IMUData, Camera as c_Camera, StreamingParameters as c_StreamingParameters, STREAMING_CODEC as c_STREAMING_CODEC, StreamingProperties as c_StreamingProperties, ObjectData as c_ObjectData, Objects as c_Objects, OBJECT_CLASS as c_OBJECT_CLASS, ObjectDetectionParameters as c_ObjectDetectionParameters, ObjectDetectionRuntimeParameters as c_ObjectDetectionRuntimeParameters, OBJECT_TRACKING_STATE as c_OBJECT_TRACKING_STATE, OBJECT_ACTION_STATE as c_OBJECT_ACTION_STATE, create_object_detection_runtime_parameters
from cython.operator cimport dereference as deref
from libc.string cimport memcpy
from cpython cimport bool

import enum

import numpy as np
cimport numpy as np
from math import sqrt

## \defgroup Video_group Video Module
## \defgroup Depth_group Depth Sensing Module
## \defgroup Core_group Core Module
## \defgroup SpatialMapping_group Spatial Mapping Module
## \defgroup PositionalTracking_group Positional Tracking Module
## \defgroup Object_group Object Detection Module
## \defgroup Sensors_group Sensors Module

##
# \ref Timesamp representation and utilities.
# \ingroup Core_group
cdef class Timestamp():
    cdef c_Timestamp timestamp

    def __cinit__(self):
        self.timestamp = c_Timestamp()

    ##
    # Timestamp in nanoseconds.
    @property
    def data_ns(self):
        return self.timestamp.data_ns

    @data_ns.setter
    def data_ns(self, ns):
        self.timestamp.data_ns = ns

    ##
    # Gets the timestamp in nanoseconds.
    def get_nanoseconds(self):
        return self.timestamp.getNanoseconds()

    ##
    # Gets the timestamp in microseconds.
    def get_microseconds(self):
        return self.timestamp.getMicroseconds()

    ##
    # Gets the timestamp in milliseconds.
    def get_milliseconds(self):
        return self.timestamp.getMilliseconds()

    ##
    # Gets the timestamp in seconds.
    def get_seconds(self):
        return self.timestamp.getSeconds()

    ##
    # Sets the timestamp to a value in nanoseconds.
    def set_nanoseconds(self, t_ns):
        self.timestamp.setNanoseconds(t_ns)

    ##
    # Sets the timestamp to a value in microoseconds.
    def set_microseconds(self, t_us):
        self.timestamp.setMicroseconds(t_us)

    ##
    # Sets the timestamp to a value in milliseconds.
    def set_milliseconds(self, t_ms):
        self.timestamp.setMilliseconds(t_ms)

    ##
    # Sets the timestamp to a value in seconds.
    def set_seconds(self, t_s):
        self.timestamp.setSeconds(t_s)

##
# Lists error codes in the ZED SDK.
# \ingroup Core_group
#
# | Enumerator                                         |                                                                                                                                                                 |
# |----------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|
# | SUCCESS                                            | Standard code for successful behavior.                                                                                                                          |
# | FAILURE                                            | Standard code for unsuccessful behavior.                                                                                                                        |
# | NO_GPU_COMPATIBLE                                  | No GPU found or CUDA capability of the device is not supported.                                                                                                 |
# | NOT_ENOUGH_GPU_MEMORY                              | Not enough GPU memory for this depth mode, try a different mode (such as PERFORMANCE), or increase the minimum depth value (see \ref InitParameters.depth_minimum_distance).                                                                          |
# | CAMERA_NOT_DETECTED                                | The ZED camera is not plugged or detected.                                                                                                                      |
# | SENSORS_NOT_AVAILABLE                               | a ZED-M or ZED2 camera is detected but the sensors (imu,barometer...) cannot be opened. Only for ZED-M or ZED2 devices.                                         |
# | INVALID_RESOLUTION                                 | In case of invalid resolution parameter, such as a upsize beyond the original image size in Camera.retrieve_image                                               |
# | LOW_USB_BANDWIDTH                                  | This issue can occurs when you use multiple ZED or a USB 2.0 port (bandwidth issue).                                                                            |
# | CALIBRATION_FILE_NOT_AVAILABLE                     | ZED calibration file is not found on the host machine. Use ZED Explorer or ZED Calibration to get one.                                                          |
# | INVALID_CALIBRATION_FILE                           | ZED calibration file is not valid, try to download the factory one or recalibrate your camera using 'ZED Calibration'.                                          |
# | INVALID_SVO_FILE                                   | The provided SVO file is not valid.                                                                                                                             |
# | SVO_RECORDING_ERROR                                | An recorder related error occurred (not enough free storage, invalid file).                                                                                     |
# | SVO_UNSUPPORTED_COMPRESSION                        | An SVO related error when NVIDIA based compression cannot be loaded.                                                                                            |
# | END_OF_SVOFILE_REACHED                             | SVO end of file has been reached, and no frame will be available until the SVO position is reset.                                                               |
# | INVALID_COORDINATE_SYSTEM                          | The requested coordinate system is not available.                                                                                                               |
# | INVALID_FIRMWARE                                   | The firmware of the ZED is out of date. Update to the latest version.                                                                                           |
# | INVALID_FUNCTION_PARAMETERS                        | An invalid parameter has been set for the function.                                                                                                             |
# | CUDA_ERROR | In grab() only, a CUDA error has been detected in the process. Activate verbose in sl.Camera.open for more info. |
# | CAMERA_NOT_INITIALIZED | In grab() only, ZED SDK is not initialized. Probably a missing call to sl.Camera.open. |
# | NVIDIA_DRIVER_OUT_OF_DATE | Your NVIDIA driver is too old and not compatible with your current CUDA version. |
# | INVALID_FUNCTION_CALL | The call of the function is not valid in the current context. Could be a missing call of sl.Camera.open |
# | CORRUPTED_SDK_INSTALLATION | The SDK wasn't able to load its dependencies, the installer should be launched. |
# | INCOMPATIBLE_SDK_VERSION | The installed SDK is incompatible SDK used to compile the program. |
# | INVALID_AREA_FILE | The given area file does not exist, check the path. |
# | INCOMPATIBLE_AREA_FILE | The area file does not contain enought data to be used or the sl.DEPTH_MODE used during the creation of the area file is different from the one currently set. |
# | CAMERA_FAILED_TO_SETUP | Failed to open the camera at the proper resolution. Try another resolution or make sure that the UVC driver is properly installed. |
# | CAMERA_DETECTION_ISSUE | Your ZED can not be opened, try replugging it to another USB port or flipping the USB-C connector. |
# | CANNOT_START_CAMERA_STREAM | Cannot start camera stream. Make sure your camera is not already used by another process or blocked by firewall or antivirus. |
# | NO_GPU_DETECTED | No GPU found, CUDA is unable to list it. Can be a driver/reboot issue. |
# | PLANE_NOT_FOUND | Plane not found, either no plane is detected in the scene, at the location or corresponding to the floor, or the floor plane doesn't match the prior given |
# | MODULE_NOT_COMPATIBLE_WITH_CAMERA | The Object detection module is only compatible with the ZED 2 and ZED Mini |
# | MOTION_SENSORS_REQUIRED | The module needs the sensors to be enabled (see \ref InitParameters.sensors_required) |
class ERROR_CODE(enum.Enum):
    SUCCESS = <int>c_ERROR_CODE.SUCCESS
    FAILURE = <int>c_ERROR_CODE.FAILURE
    NO_GPU_COMPATIBLE = <int>c_ERROR_CODE.NO_GPU_COMPATIBLE
    NOT_ENOUGH_GPU_MEMORY = <int>c_ERROR_CODE.NOT_ENOUGH_GPU_MEMORY
    CAMERA_NOT_DETECTED = <int>c_ERROR_CODE.CAMERA_NOT_DETECTED
    SENSORS_NOT_AVAILABLE = <int>c_ERROR_CODE.SENSORS_NOT_AVAILABLE
    INVALID_RESOLUTION = <int>c_ERROR_CODE.INVALID_RESOLUTION
    LOW_USB_BANDWIDTH = <int>c_ERROR_CODE.LOW_USB_BANDWIDTH
    CALIBRATION_FILE_NOT_AVAILABLE = <int>c_ERROR_CODE.CALIBRATION_FILE_NOT_AVAILABLE
    INVALID_CALIBRATION_FILE = <int>c_ERROR_CODE.INVALID_CALIBRATION_FILE
    INVALID_SVO_FILE = <int>c_ERROR_CODE.INVALID_SVO_FILE
    SVO_RECORDING_ERROR = <int>c_ERROR_CODE.SVO_RECORDING_ERROR
    END_OF_SVOFILE_REACHED = <int>c_ERROR_CODE.END_OF_SVOFILE_REACHED
    SVO_UNSUPPORTED_COMPRESSION = <int>c_ERROR_CODE.SVO_UNSUPPORTED_COMPRESSION
    INVALID_COORDINATE_SYSTEM = <int>c_ERROR_CODE.INVALID_COORDINATE_SYSTEM
    INVALID_FIRMWARE = <int>c_ERROR_CODE.INVALID_FIRMWARE
    INVALID_FUNCTION_PARAMETERS = <int>c_ERROR_CODE.INVALID_FUNCTION_PARAMETERS
    CUDA_ERROR = <int>c_ERROR_CODE.CUDA_ERROR
    CAMERA_NOT_INITIALIZED = <int>c_ERROR_CODE.CAMERA_NOT_INITIALIZED
    NVIDIA_DRIVER_OUT_OF_DATE = <int>c_ERROR_CODE.NVIDIA_DRIVER_OUT_OF_DATE
    INVALID_FUNCTION_CALL = <int>c_ERROR_CODE.INVALID_FUNCTION_CALL
    CORRUPTED_SDK_INSTALLATION = <int>c_ERROR_CODE.CORRUPTED_SDK_INSTALLATION
    INCOMPATIBLE_SDK_VERSION = <int>c_ERROR_CODE.INCOMPATIBLE_SDK_VERSION
    INVALID_AREA_FILE = <int>c_ERROR_CODE.INVALID_AREA_FILE
    INCOMPATIBLE_AREA_FILE = <int>c_ERROR_CODE.INCOMPATIBLE_AREA_FILE
    CAMERA_FAILED_TO_SETUP = <int>c_ERROR_CODE.CAMERA_FAILED_TO_SETUP
    CAMERA_DETECTION_ISSUE = <int>c_ERROR_CODE.CAMERA_DETECTION_ISSUE
    CANNOT_START_CAMERA_STREAM = <int>c_ERROR_CODE.CANNOT_START_CAMERA_STREAM
    NO_GPU_DETECTED =<int> c_ERROR_CODE.NO_GPU_DETECTED
    PLANE_NOT_FOUND = <int>c_ERROR_CODE.PLANE_NOT_FOUND
    MODULE_NOT_COMPATIBLE_WITH_CAMERA = <int>c_ERROR_CODE.MODULE_NOT_COMPATIBLE_WITH_CAMERA
    MOTION_SENSORS_REQUIRED = <int>c_ERROR_CODE.MOTION_SENSORS_REQUIRED
    LAST = <int>c_ERROR_CODE.LAST

    def __str__(self):
        return to_str(toString(<c_ERROR_CODE>(<unsigned int>self.value))).decode()

    def __repr__(self):
        return to_str(toString(<c_ERROR_CODE>(<unsigned int>self.value))).decode()

##
# Lists compatible ZED Camera model
#
# \ingroup Video_group
#
# | Enumerator     |                  |
# |------------|------------------|
# | ZED        | Defines ZED Camera model |
# | ZED_M      | Defines ZED Mini (ZED-M) Camera model |
# | ZED2 | Defines ZED 2 Camera model |
class MODEL(enum.Enum):
    ZED = <int>c_MODEL.ZED
    ZED_M = <int>c_MODEL.ZED_M
    ZED2 = <int>c_MODEL.ZED2
    LAST = <int>c_MODEL.MODEL_LAST

    def __str__(self):
        return to_str(toString(<c_MODEL>(<unsigned int>self.value))).decode()

    def __repr__(self):
        return to_str(toString(<c_MODEL>(<unsigned int>self.value))).decode()

##
# List of possible camera state
#
# \ingroup Video_group
#
# | Enumerator     |                  |
# |------------|------------------|
# | AVAILABLE | Defines if the camera can be opened by the SDK |
# | NOT_AVAILABLE | Defines if the camera is already opened and unavailable |
class CAMERA_STATE(enum.Enum):
    AVAILABLE = <int>c_CAMERA_STATE.AVAILABLE
    NOT_AVAILABLE = <int>c_CAMERA_STATE.NOT_AVAILABLE
    LAST = <int>c_CAMERA_STATE.CAMERA_STATE_LAST

    def __str__(self):
        return to_str(toString(<c_CAMERA_STATE>(<unsigned int>self.value))).decode()

    def __repr__(self):
        return to_str(toString(<c_CAMERA_STATE>(<unsigned int>self.value))).decode()

##
# Tells the program to wait for x ms.
# \ingroup Core_group
#
#  @param time : the number of ms to wait.
#
def c_sleep_ms(int time):
    sleep_ms(time)

##
# Properties of a camera.
# \ingroup Video_group
#
# \note
#   A camera_model ZED_M with an id '-1' can be due to an inverted USB-C cable.
#
# \warning
#   Experimental on Windows.
#
cdef class DeviceProperties:
    cdef c_DeviceProperties c_device_properties

    def __cinit__(self):
        self.c_device_properties = c_DeviceProperties()

    ##
    # the camera state
    @property
    def camera_state(self):
        return CAMERA_STATE(<int>self.c_device_properties.camera_state)

    @camera_state.setter
    def camera_state(self, camera_state):
        if isinstance(camera_state, CAMERA_STATE):
            self.c_device_properties.camera_state = (<c_CAMERA_STATE> (<unsigned int>camera_state.value))
        else:
            raise TypeError("Argument is not of CAMERA_STATE type.")

    ##
    # the camera id (Notice that only the camera with id '0' can be used on Windows)
    @property
    def id(self):
        return self.c_device_properties.id

    @id.setter
    def id(self, id):
        self.c_device_properties.id = id

    ##
    # the camera system path
    @property
    def path(self):
        if not self.c_device_properties.path.empty():
            return self.c_device_properties.path.get().decode()
        else:
            return ""

    @path.setter
    def path(self, str path):
        path_ = path.encode()
        self.c_device_properties.path = (String(<char*> path_))

    ##
    # the camera model
    @property
    def camera_model(self):
        return MODEL(<int>self.c_device_properties.camera_model)

    @camera_model.setter
    def camera_model(self, camera_model):
        if isinstance(camera_model, MODEL):
            self.c_device_properties.camera_model = (<c_MODEL> (<unsigned int>camera_model.value))
        else:
            raise TypeError("Argument is not of MODEL type.")
    ##
    # the camera serial number
    @property
    def serial_number(self):
        return self.c_device_properties.serial_number

    @serial_number.setter
    def serial_number(self, serial_number):
        self.c_device_properties.serial_number = serial_number

    def __str__(self):
        return to_str(toString(self.c_device_properties)).decode()

    def __repr__(self):
        return to_str(toString(self.c_device_properties)).decode()


##
# Represents a generic 3*3 matrix
# \ingroup Core_group
#
# It is defined in a row-major order, it means that, in the value buffer, the entire first row is stored first, followed by the entire second row, and so on.
# You can access the data with the 'r' ptr or by element attribute.
# | | | |
# |-|-|-|
# | r00 | r01 | r02 |
# | r10 | r11 | r12 |
# | r20 | r21 | r22 |
cdef class Matrix3f:
    cdef c_Matrix3f mat
    def __cinit__(self):
        self.mat = c_Matrix3f()

    ##
    # Creates a \ref Matrix3f from another \ref Matrix3f
    # \param matrix : the \ref Matrix3f to copy
    def init_matrix(self, Matrix3f matrix):
        self.mat = c_Matrix3f(matrix.mat)

    ##
    # Inverses the matrix.
    def inverse(self):
        self.mat.inverse()

    ##
    # Inverses the \ref Matrix3f passed as a parameter.
    # \param rotation : the \ref Matrix3f to inverse
    # \return the inversed \ref Matrix3f
    def inverse_mat(self, Matrix3f rotation):
        rotation.mat.inverse(rotation.mat)
        return rotation

    ##
    # Sets the RotationArray to its transpose.
    def transpose(self):
        self.mat.transpose()

    ##
    # Returns the transpose of a \ref Matrix3f
    # \param rotation : the \ref Matrix3f to compute the transpose from.
    # \return The transpose of the given \ref Matrix3f
    def transpose(self, Matrix3f rotation):
        rotation.mat.transpose(rotation.mat)
        return rotation

    ##
    # Sets the \ref Matrix3f to identity.
    # \return itself
    def set_identity(self):
        self.mat.setIdentity()
        return self

    ##
    # Creates an identity \ref Matrix3f
    # \return a \ref Matrix3f set to identity
    def identity(self):
        new_mat = Matrix3f()
        return new_mat.set_identity()

    ##
    # Sets the \ref Matrix3f to zero.
    def set_zeros(self):
        self.mat.setZeros()

    ##
    # Creates a \ref Matrix3f filled with zeros.
    # \return A \ref Matrix3f filled with zeros
    def zeros(self):
        self.mat.zeros()
        return self

    ##
    # Returns the components of the \ref Matrix3f in a string.
    # \return A string containing the components of the current of \ref Matrix3f
    def get_infos(self):
        return to_str(self.mat.getInfos()).decode()

    ##
    # Name of the matrix (optional).
    @property
    def matrix_name(self):
        if not self.mat.matrix_name.empty():
            return self.mat.matrix_name.get().decode()
        else:
            return ""

    @matrix_name.setter
    def matrix_name(self, str name):
        self.mat.matrix_name.set(name.encode()) 

    @property
    def nbElem(self):
        return self.mat.nbElem

    ##
    # Numpy array of inner data
    @property
    def r(self):
        nbElem = self.nbElem
        sqrt_nbElem = int(sqrt(nbElem))
        cdef np.ndarray arr = np.zeros(nbElem)
        for i in range(nbElem):
            arr[i] = self.mat.r[i]
        return arr.reshape(sqrt_nbElem, sqrt_nbElem)

    @r.setter
    def r(self, value):
        if isinstance(value, list):
            if len(value) <= self.nbElem:
                for i in range(len(value)):
                    self.mat.r[i] = value[i]
            else:
                raise IndexError("Value list must be of length 9 max.")
        elif isinstance(value, np.ndarray):
            if value.size <= self.nbElem:
                for i in range(value.size):
                    self.mat.r[i] = value[i]
            else:
                raise IndexError("Numpy array must be of size 9.")
        else:
            raise TypeError("Argument must be numpy array or list type.")

    def __mul__(self, other):
        matrix = Matrix3f()
        if isinstance(other, Matrix3f):
            matrix.r = (self.r * other.r).reshape(self.nbElem)
        elif isinstance(other, float) or isinstance(other, int) or isinstance(other, long):
            matrix.r = (other * self.r).reshape(self.nbElem)
        else:
            raise TypeError("Argument must be Matrix3f or scalar type.")
        return matrix

    def __richcmp__(Matrix3f left, Matrix3f right, int op):
        if op == 2:
            return left.mat == right.mat
        if op == 3:
            return left.mat != right.mat
        else:
            raise NotImplementedError()

    def __getitem__(self, x):
        return self.r[x]

    def __setitem__(self, key, value):
        if key == (0,0):
            self.mat.r00 = value
        elif key == (0,1):
            self.mat.r01 = value
        elif key == (0,2):
            self.mat.r02 = value
        elif key == (1,0):
            self.mat.r10 = value
        elif key == (1,1):
            self.mat.r11 = value
        elif key == (1,2):
            self.mat.r12 = value
        elif key == (2,0):
            self.mat.r20 = value
        elif key == (2,1):
            self.mat.r21 = value
        elif key == (2,2):
            self.mat.r22 = value

    def __repr__(self):
        return self.get_infos()

##
# Represents a generic fourth-dimensional matrix.
# \ingroup Core_group
# It is defined in a row-major order, it means that, in the value buffer, the entire first row is stored first, followed by the entire second row, and so on.
# You can access the data by the 'm' ptr or by the element attribute.
#
# | | | | |
# |-|-|-|-|
# | r00 | r01 | r02 | tx |
# | r10 | r11 | r12 | ty |
# | r20 | r21 | r22 | tz |
# | m30 | m31 | m32 | m33 |
cdef class Matrix4f:
    cdef c_Matrix4f mat
    def __cinit__(self):
        self.mat = c_Matrix4f()

    ##
    # Creates a \ref Matrix4f from another \ref Matrix4f (deep copy)
    # \param matrix : the \ref Matrix4f to copy
    def init_matrix(self, Matrix4f matrix):
        self.mat = c_Matrix4f(matrix.mat)

    ##
    # Inverses the matrix.
    def inverse(self):
        return ERROR_CODE(<int><int>(self.mat.inverse()))

    ##
    # Inverses the \ref Matrix4f passed as a parameter
    # \param rotation : the \ref Matrix4f to inverse
    # \return the inversed \ref Matrix4f
    def inverse_mat(self, Matrix4f rotation):
        rotation.mat.inverse(rotation.mat)
        return rotation

    ##
    # Sets the RotationArray to its transpose.
    def transpose(self):
        self.mat.transpose()

    ##
    # Returns the transpose of a \ref Matrix4f
    # \param rotation : the \ref Matrix4f to compute the transpose from.
    # \return the transposed \ref Matrix4f
    def transpose(self, Matrix4f rotation):
        rotation.mat.transpose(rotation.mat)
        return rotation

    ##
    # Sets the \ref Matrix4f to identity
    # \return itself
    def set_identity(self):
        self.mat.setIdentity()
        return self

    ##
    # Creates an identity \ref Matrix4f
    # \return A \ref Matrix4f set to identity
    def identity(self):
        new_mat = Matrix4f()
        return new_mat.set_identity()

    ##
    # Sets the \ref Matrix4f to zero.
    def set_zeros(self):
        self.mat.setZeros()

    ##
    # Creates a \ref Matrix4f  filled with zeros.
    # \return A \ref Matrix4f filled with zeros.
    def zeros(self):
        self.mat.zeros()
        return self

    ##
    # Returns the components of the \ref Matrix4f in a string.
    # \return A string containing the components of the current \ref Matrix4f
    def get_infos(self):
        return to_str(self.mat.getInfos()).decode()

    ##
    # Sets a 3x3 Matrix inside the \ref Matrix4f
    # \note Can be used to set the rotation matrix when the matrix4f is a pose or an isometric matrix.
    # \param input : sub matrix to put inside the  \ref Matrix4f
    # \param row : index of the row to start the 3x3 block. Must be 0 or 1.
    # \param column : index of the column to start the 3x3 block. Must be 0 or 1.
    #
    # \return \ref ERROR_CODE.SUCCESS if everything went well, \ref ERROR_CODE.FAILURE otherwise.
    def set_sub_matrix3f(self, Matrix3f input, row=0, column=0):
        if row != 0 and row != 1 or column != 0 and column != 1:
            raise TypeError("Arguments row and column must be 0 or 1.")
        else:
            return ERROR_CODE(<int>self.mat.setSubMatrix3f(input.mat, row, column))

    ##
    # Sets a 3x1 Vector inside the \ref Matrix4f at the specifided column index.
    # \note Can be used to set the Translation/Position matrix when the matrix4f is a pose or an isometry.
    # \param input : sub vector to put inside the \ref Matrix4f
    # \param column : index of the column to start the 3x3 block. By default, it is the last column (translation for a \ref Pose ).
    # \return \ref ERROR_CODE.SUCCESS if everything went well, \ref ERROR_CODE.FAILURE otherwise.
    def set_sub_vector3f(self, float input0, float input1, float input2, column=3):
        return ERROR_CODE(<int>self.mat.setSubVector3f(Vector3[float](input0, input1, input2), column))

    ##
    # Sets a 4x1 Vector inside the \ref Matrix4f at the specifided column index.
    # \param input : sub vector to put inside the \ref Matrix4f
    # \param column : index of the column to start the 3x3 block. By default, it is the last column (translation for a \ref Pose ).
    # \return \ref ERROR_CODE.SUCCESS if everything went well, \ref ERROR_CODE.FAILURE otherwise.
    def set_sub_vector4f(self, float input0, float input1, float input2, float input3, column=3):
        return ERROR_CODE(<int>self.mat.setSubVector4f(Vector4[float](input0, input1, input2, input3), column))

    @property
    def nbElem(self):
        return self.mat.nbElem

    ##
    # Returns the components of the \ref Matrix4f in a string.
    @property
    def matrix_name(self):
        if not self.mat.matrix_name.empty():
            return self.mat.matrix_name.get().decode()
        else:
            return ""

    @matrix_name.setter
    def matrix_name(self, str name):
        self.mat.matrix_name.set(name.encode())

    ##
    # Access to the content of the \ref Matrix4f as a numpy array or list.
    @property
    def m(self):
        nbElem = self.nbElem
        sqrt_nbElem = int(sqrt(nbElem))
        cdef np.ndarray arr = np.zeros(nbElem)
        for i in range(nbElem):
            arr[i] = self.mat.m[i]
        return arr.reshape(sqrt_nbElem, sqrt_nbElem)

    @m.setter
    def m(self, value):
        if isinstance(value, list):
            if len(value) <= self.nbElem:
                for i in range(len(value)):
                    self.mat.m[i] = value[i]
            else:
                raise IndexError("Value list must be of length 16 max.")
        elif isinstance(value, np.ndarray):
            if value.size <= self.nbElem:
                for i in range(value.size):
                    self.mat.m[i] = value[i]
            else:
                raise IndexError("Numpy array must be of size 16.")
        else:
            raise TypeError("Argument must be numpy array or list type.")

    def __mul__(self, other):
        matrix = Matrix4f()
        if isinstance(other, Matrix4f) :
            matrix.m = (self.m * other.m).reshape(self.nbElem)
        elif isinstance(other, float) or isinstance(other, int) or isinstance(other, long):
            matrix.m = (other * self.m).reshape(self.nbElem)
        else:
            raise TypeError("Argument must be Matrix4f or scalar type.")
        return matrix

    def __richcmp__(Matrix4f left, Matrix4f right, int op):
        if op == 2:
            return left.mat == right.mat
        if op == 3:
            return left.mat != right.mat
        else:
            raise NotImplementedError()

    def __getitem__(self, x):
        return self.m[x]

    def __setitem__(self, key, value):
        if key == (0,0):
            self.mat.r00 = value
        elif key == (0,1):
            self.mat.r01 = value
        elif key == (0,2):
            self.mat.r02 = value
        elif key == (0,3):
            self.mat.tx = value
        elif key == (1,0):
            self.mat.r10 = value
        elif key == (1,1):
            self.mat.r11 = value
        elif key == (1,2):
            self.mat.r12 = value
        elif key == (1,3):
            self.mat.ty = value
        elif key == (2,0):
            self.mat.r20 = value
        elif key == (2,1):
            self.mat.r21 = value
        elif key == (2,2):
            self.mat.r22 = value
        elif key == (2,3):
            self.mat.tz = value
        elif key == (3,0):
            self.mat.m30 = value
        elif key == (3,1):
            self.mat.m31 = value
        elif key == (3,2):
            self.mat.m32 = value
        elif key == (3,3):
            self.mat.m33 = value

    def __repr__(self):
        return self.get_infos()

##
# Represents the available resolution list.
# \ingroup Core_group
# \note The VGA resolution does respect the 640*480 standard to better fit the camera sensor (672*376 is used).
#
# | Enumerator |            |
# |------------|------------|
# | HD2K | 2208*1242, available framerates: 15 fps. |
# | HD1080 | 1920*1080, available framerates: 15, 30 fps. |
# | HD720 | 1280*720, available framerates: 15, 30, 60 fps |
# | VGA | 672*376, available framerates: 15, 30, 60, 100 fps. |
class RESOLUTION(enum.Enum):
    HD2K = <int>c_RESOLUTION.HD2K
    HD1080 = <int>c_RESOLUTION.HD1080
    HD720 = <int>c_RESOLUTION.HD720
    VGA  = <int>c_RESOLUTION.VGA
    LAST = <int>c_RESOLUTION.RESOLUTION_LAST

##
# Lists available camera settings for the ZED camera (contrast, hue, saturation, gain...).
# \ingroup Video_group
#
# \warning GAIN and EXPOSURE are linked in auto/default mode (see \ref Camera.set_camera_settings).
# 
# Each enum defines one of those settings.
#
# | Enumerator |                         |
# |------------|-------------------------|
# | BRIGHTNESS | Defines the brightness control. Affected value should be between 0 and 8. |
# | CONTRAST | Defines the contrast control. Affected value should be between 0 and 8. |
# | HUE | Defines the hue control. Affected value should be between 0 and 11. |
# | SATURATION | Defines the saturation control. Affected value should be between 0 and 8. |
# | SHARPNESS | Defines the digital sharpening control. Affected value should be betwwen 0 and 8. |
# | GAIN |  Defines the gain control. Affected value should be between 0 and 100 for manual control. |
# | EXPOSURE | Defines the exposure control. Affected value should be between 0 and 100 for manual control.\n The exposition is mapped linearly in a percentage of the following max values. Special case for set_exposure(0) that corresponds to 0.17072ms.\n The conversion to milliseconds depends on the framerate: <ul><li>15fps set_exposure(100) -> 19.97ms</li><li>30fps set_exposure(100) -> 19.97ms</li><li>60fps se_exposure(100) -> 10.84072ms</li><li>100fps set_exposure(100) -> 10.106624ms</li></ul> |
# | AEC_AGC | Defines if the Gain and Exposure are in automatic mode or not. Setting a Gain or Exposure through @GAIN or @EXPOSURE values will automatically set this value to 0. |
# | WHITEBALANCE_TEMPERATURE | Defines the color temperature value. Setting a value will automatically set @WHITEBALANCE_AUTO to 0. Affected value should be between 2800 and 6500 with a step of 100. |
# | WHITEBALANCE_AUTO | Defines if the White balance is in automatic mode or not |
# | Defines the status of the camera front LED. Set to 0 to disable the light, 1 to enable the light. Default value is on. Requires Camera FW 1523 at least |
class VIDEO_SETTINGS(enum.Enum):
    BRIGHTNESS = <int>c_VIDEO_SETTINGS.BRIGHTNESS
    CONTRAST = <int>c_VIDEO_SETTINGS.CONTRAST
    HUE = <int>c_VIDEO_SETTINGS.HUE
    SATURATION = <int>c_VIDEO_SETTINGS.SATURATION
    SHARPNESS = <int>c_VIDEO_SETTINGS.SHARPNESS
    GAIN = <int>c_VIDEO_SETTINGS.GAIN
    EXPOSURE = <int>c_VIDEO_SETTINGS.EXPOSURE
    AEC_AGC = <int>c_VIDEO_SETTINGS.AEC_AGC
    WHITEBALANCE_TEMPERATURE = <int>c_VIDEO_SETTINGS.WHITEBALANCE_TEMPERATURE
    WHITEBALANCE_AUTO = <int>c_VIDEO_SETTINGS.WHITEBALANCE_AUTO
    LED_STATUS = <int>c_VIDEO_SETTINGS.LED_STATUS
    LAST = <int>c_VIDEO_SETTINGS.VIDEO_SETTINGS_LAST

##
# Lists available depth computation modes.
# \ingroup Depth_group
#
# | Enumerator |                         |
# |------------|-------------------------|
# | NONE | This mode does not compute any depth map. Only rectified stereo images will be available. |
# | PERFORMANCE | Computation mode optimized for speed. |
# | QUALITY | Computation mode designed for high quality results. |
# | ULTRA | Computation mode favorising edges and sharpness. Requires more GPU memory and computation power. |
class DEPTH_MODE(enum.Enum):
    NONE = <int>c_DEPTH_MODE.NONE
    PERFORMANCE = <int>c_DEPTH_MODE.PERFORMANCE
    QUALITY = <int>c_DEPTH_MODE.QUALITY
    ULTRA = <int>c_DEPTH_MODE.ULTRA
    LAST = <int>c_DEPTH_MODE.DEPTH_MODE_LAST

##
# Lists available depth sensing modes.
# \ingroup Depth_group
#
# | Enumerator |                         |
# |------------|-------------------------|
# | STANDARD | This mode outputs ZED standard depth map that preserves edges and depth accuracy.\n- Applications example: Obstacle detection, Automated navigation, People detection, 3D reconstruction, measurements. |
# | FILL | This mode outputs a smooth and fully dense depth map.\n- Applications example: AR/VR, Mixed-reality capture, Image post-processing. |
class SENSING_MODE(enum.Enum):
    STANDARD = <int>c_SENSING_MODE.STANDARD
    FILL = <int>c_SENSING_MODE.FILL
    LAST = <int>c_SENSING_MODE.SENSING_MODE_LAST

##
# Lists availablpe unit for measures.
# \ingroup Core_group
# 
# | Enumerator |                         |
# |------------|-------------------------|
# | MILLIMETER | International System, 1/1000 METER. |
# | CENTIMETER | International System, 1/100 METER. |
# | METER | International System, 1 METER |
# | INCH | Imperial Unit, 1/12 FOOT |
# | FOOT | Imperial Unit, 1/12 FOOT |
class UNIT(enum.Enum):
    MILLIMETER = <int>c_UNIT.MILLIMETER
    CENTIMETER = <int>c_UNIT.CENTIMETER
    METER = <int>c_UNIT.METER
    INCH = <int>c_UNIT.INCH
    FOOT = <int>c_UNIT.FOOT
    LAST = <int>c_UNIT.UNIT_LAST


##
# Lists available coordinates systems for positional tracking and 3D measures.
# \ingroup Core_group
# 
# | Enumerator |                         |
# |------------|-------------------------|
# | IMAGE | Standard coordinates system in computer vision. Used in OpenCV : see here : http://docs.opencv.org/2.4/modules/calib3d/doc/camera_calibration_and_3d_reconstruction.html |
# | LEFT_HANDED_Y_UP | Left-Handed with Y up and Z forward. Used in Unity with DirectX. |
# | RIGHT_HANDED_Y_UP | Right-Handed with Y pointing up and Z backward. Used in OpenGL. |
# | RIGHT_HANDED_Z_UP | Right-Handed with Z pointing up and Y forward. Used in 3DSMax. |
# | LEFT_HANDED_Z_UP | Left-Handed with Z axis pointing up and X forward. Used in Unreal Engine. |
# | RIGHT_HANDED_Z_UP_X_FWD | Right-Handed with Z pointing up and X forward. Used in ROS (REP 103). |
class COORDINATE_SYSTEM(enum.Enum):
    IMAGE = <int>c_COORDINATE_SYSTEM.IMAGE
    LEFT_HANDED_Y_UP = <int>c_COORDINATE_SYSTEM.LEFT_HANDED_Y_UP
    RIGHT_HANDED_Y_UP = <int>c_COORDINATE_SYSTEM.RIGHT_HANDED_Y_UP
    RIGHT_HANDED_Z_UP = <int>c_COORDINATE_SYSTEM.RIGHT_HANDED_Z_UP
    LEFT_HANDED_Z_UP = <int>c_COORDINATE_SYSTEM.LEFT_HANDED_Z_UP
    RIGHT_HANDED_Z_UP_X_FWD = <int>c_COORDINATE_SYSTEM.RIGHT_HANDED_Z_UP_X_FWD
    LAST = <int>c_COORDINATE_SYSTEM.COORDINATE_SYSTEM_LAST

    def __str__(self):
        return to_str(toString(<c_COORDINATE_SYSTEM>(<unsigned int>self.value))).decode()

    def __repr__(self):
        return to_str(toString(<c_COORDINATE_SYSTEM>(<unsigned int>self.value))).decode()

##
# Lists retrievable measures.
# \ingroup Core_group
# | Enumerator |                         |
# |------------|-------------------------|
# | DISPARITY | Disparity map. Each pixel contains 1 float. sl.MAT_TYPE.F32_C1. |
# | DEPTH | Depth map. Each pixel contains 1 float. sl.MAT_TYPE.F32_C1. |
# | CONFIDENCE | Certainty/confidence of the depth map. Each pixel contains 1 float. sl.MAT_TYPE.F32_C1 |
# | XYZ | Point cloud. Each pixel contains 4 float (X, Y, Z, not used). sl.MAT_TYPE.F32_C4. |
# | XYZRGBA | Colored point cloud. Each pixel contains 4 float (X, Y, Z, color). The color need to be read as an usigned char[4] representing the RGBA color.  sl.MAT_TYPE.F32_C4. |
# | XYZBGRA | Colored point cloud. Each pixel contains 4 float (X, Y, Z, color). The color need to be read as an usigned char[4] representing the BGRA color.  sl.MAT_TYPE.F32_C4. |
# | XYZARGB | Colored point cloud. Each pixel contains 4 float (X, Y, Z, color). The color need to be read as an usigned char[4] representing the BGRA color.  sl.MAT_TYPE.F32_C4. |
# | XYZABGR | Colored point cloud. Each pixel contains 4 float (X, Y, Z, color). The color need to be read as an usigned char[4] representing the BGRA color.  sl.MAT_TYPE.F32_C4. |
# | NORMALS | Normals vector. Each pixel contains 4 float (X, Y, Z, 0).  sl.MAT_TYPE.F32_C4. |
# | DISPARITY_RIGHT | Disparity map for right sensor. Each pixel contains 1 float. sl.MAT_TYPE.F32_C1 |
# | DEPTH_RIGHT | Depth map for right sensor. Each pixel contains 1 float. sl.MAT_TYPE.F32_C1 |
# | XYZ_RIGHT | Point cloud for right sensor. Each pixel contains 4 float (X, Y, Z, not used). sl.MAT_TYPE.F32_C4 |
# | XYZRGBA_RIGHT | Colored point cloud for right sensor. Each pixel contains 4 float (X, Y, Z, color). The color need to be read as an usigned char[4] representing the RGBA color. sl.MAT_TYPE.F32_C4 |
# | XYZBGRA_RIGHT | Colored point cloud for right sensor. Each pixel contains 4 float (X, Y, Z, color). The color need to be read as an usigned char[4] representing the RGBA color. sl.MAT_TYPE.F32_C4 |
# | XYZARGB_RIGHT | Colored point cloud for right sensor. Each pixel contains 4 float (X, Y, Z, color). The color need to be read as an usigned char[4] representing the RGBA color. sl.MAT_TYPE.F32_C4 |
# | XYZABGR_RIGHT | Colored point cloud for right sensor. Each pixel contains 4 float (X, Y, Z, color). The color need to be read as an usigned char[4] representing the RGBA color. sl.MAT_TYPE.F32_C4 |
# | XYZABGR_RIGHT | Colored point cloud for right sensor. Each pixel contains 4 float (X, Y, Z, color). The color need to be read as an usigned char[4] representing the RGBA color. sl.MAT_TYPE.F32_C4 |
class MEASURE(enum.Enum):
    DISPARITY = <int>c_MEASURE.DISPARITY
    DEPTH = <int>c_MEASURE.DEPTH
    CONFIDENCE = <int>c_MEASURE.CONFIDENCE
    XYZ = <int>c_MEASURE.XYZ
    XYZRGBA = <int>c_MEASURE.XYZRGBA
    XYZBGRA = <int>c_MEASURE.XYZBGRA
    XYZARGB = <int>c_MEASURE.XYZARGB
    XYZABGR = <int>c_MEASURE.XYZABGR
    NORMALS = <int>c_MEASURE.NORMALS
    DISPARITY_RIGHT = <int>c_MEASURE.DISPARITY_RIGHT
    DEPTH_RIGHT = <int>c_MEASURE.DEPTH_RIGHT
    XYZ_RIGHT = <int>c_MEASURE.XYZ_RIGHT
    XYZRGBA_RIGHT = <int>c_MEASURE.XYZRGBA_RIGHT
    XYZBGRA_RIGHT = <int>c_MEASURE.XYZBGRA_RIGHT
    XYZARGB_RIGHT = <int>c_MEASURE.XYZARGB_RIGHT
    XYZABGR_RIGHT = <int>c_MEASURE.XYZABGR_RIGHT
    NORMALS_RIGHT = <int>c_MEASURE.NORMALS_RIGHT
    LAST = <int>c_MEASURE.MEASURE_LAST

    def __str__(self):
        return to_str(toString(<c_MEASURE>(<unsigned int>self.value))).decode()

    def __repr__(self):
        return to_str(toString(<c_MEASURE>(<unsigned int>self.value))).decode()

##
# Lists available views.
# \ingroup Video_group
#
# | Enumerator |                         |
# |------------|-------------------------|
# | LEFT | Left RGBA image. Each pixel contains 4 usigned char (R,G,B,A). sl.MAT_TYPE.U8_C4. |
# | RIGHT | Right RGBA image. Each pixel contains 4 usigned char (R,G,B,A). sl.MAT_TYPE.U8_C4. |
# | LEFT_GRAY | Left GRAY image. Each pixel contains 1 usigned char. sl.MAT_TYPE.U8_C1 |
# | RIGHT_GRAY | Right GRAY image. Each pixel contains 1 usigned char. sl.MAT_TYPE.U8_C1 |
# | LEFT_UNRECTIFIED | Left RGBA unrectified image. Each pixel contains 4 usigned char (R,G,B,A). sl.MAT_TYPE.U8_C4 |
# | RIGHT_UNRECTIFIED | Right RGBA unrectified image. Each pixel contains 4 usigned char (R,G,B,A). sl.MAT_TYPE.U8_C4 |
# | LEFT_UNRECTIFIED_GRAY | Left GRAY unrectified image. Each pixel contains 1 usigned char. sl.MAT_TYPE.U8_C1 |
# | RIGHT_UNRECTIFIED_GRAY | Right GRAY unrectified image. Each pixel contains 1 usigned char. sl.MAT_TYPE.U8_C1 |
# | SIDE_BY_SIDE | Left and right image (the image width is therefore doubled). Each pixel contains 4 usigned char (R,G,B,A). sl.MAT_TYPE.U8_C4 |
# | DEPTH | Color rendering of the depth. Each pixel contains 4 usigned char (R,G,B,A). sl.MAT_TYPE.U8_C4. Use \ref MEASURE "MEASURE.DEPTH" with \ref Camera.retrieve_measure() to get depth values. |
# | CONFIDENCE | Color rendering of the depth confidence. Each pixel contains 4 usigned char (R,G,B,A). sl.MAT_TYPE.U8_C4 |
# | NORMALS | Color rendering of the normals. Each pixel contains 4 usigned char (R,G,B,A). sl.MAT_TYPE.U8_C4 |
# | DEPTH_RIGHT | Color rendering of the right depth mapped on right sensor, sl.MAT_TYPE.U8_C4 |
# | NORMALS_RIGHT | Color rendering of the normals mapped on right sensor. Each pixel contains 4 usigned char (R,G,B,A). sl.MAT_TYPE.U8_C4 |
class VIEW(enum.Enum):
    LEFT = <int>c_VIEW.LEFT
    RIGHT = <int>c_VIEW.RIGHT
    LEFT_GRAY = <int>c_VIEW.LEFT_GRAY
    RIGHT_GRAY = <int>c_VIEW.RIGHT_GRAY
    LEFT_UNRECTIFIED = <int>c_VIEW.LEFT_UNRECTIFIED
    RIGHT_UNRECTIFIED = <int>c_VIEW.RIGHT_UNRECTIFIED
    LEFT_UNRECTIFIED_GRAY = <int>c_VIEW.LEFT_UNRECTIFIED_GRAY
    RIGHT_UNRECTIFIED_GRAY = <int>c_VIEW.RIGHT_UNRECTIFIED_GRAY
    SIDE_BY_SIDE = <int>c_VIEW.SIDE_BY_SIDE
    DEPTH = <int>c_VIEW.VIEW_DEPTH
    CONFIDENCE = <int>c_VIEW.VIEW_CONFIDENCE
    NORMALS = <int>c_VIEW.VIEW_NORMALS
    DEPTH_RIGHT = <int>c_VIEW.VIEW_DEPTH_RIGHT
    NORMALS_RIGHT = <int>c_VIEW.VIEW_NORMALS_RIGHT
    LAST = <int>c_VIEW.VIEW_LAST

    def __str__(self):
        return to_str(toString(<c_VIEW>(<unsigned int>self.value))).decode()

    def __repr__(self):
        return to_str(toString(<c_VIEW>(<unsigned int>self.value))).decode()

##
# Lists the different states of positional tracking.
# \ingroup PositionalTracking_group
#
# | Enumerator |                         |
# |------------|-------------------------|
# | SEARCHING | The camera is searching for a previously known position to locate itself. |
# | OK | Positional tracking is working normally. |
# | OFF | Positional tracking is not enabled. |
# | FPS_TOO_LOW | Effective FPS is too low to give proper results for motion tracking. Consider using PERFORMANCES parameters (DEPTH_MODE.PERFORMANCE, low camera resolution (VGA,HD720)) |
class POSITIONAL_TRACKING_STATE(enum.Enum):
    SEARCHING = <int>c_POSITIONAL_TRACKING_STATE.SEARCHING
    OK = <int>c_POSITIONAL_TRACKING_STATE.OK
    OFF = <int>c_POSITIONAL_TRACKING_STATE.OFF
    FPS_TOO_LOW = <int>c_POSITIONAL_TRACKING_STATE.FPS_TOO_LOW
    LAST = <int>c_POSITIONAL_TRACKING_STATE.POSITIONAL_TRACKING_STATE_LAST

##
# Lists the different states of spatial memory area export.
# \ingroup SpatialMapping_group
#
# | Enumerator |                         |
# |------------|-------------------------|
# | SUCCESS | The spatial memory file has been successfully created. |
# | RUNNING | The spatial memory is currently written. |
# | NOT_STARTED | The spatial memory file exportation has not been called. |
# | FILE_EMPTY | The spatial memory contains no data, the file is empty. |
# | FILE_ERROR | The spatial memory file has not been written because of a wrong file name. |
# | SPATIAL_MEMORY_DISABLED | The spatial memory learning is disable, no file can be created. |
class AREA_EXPORTING_STATE(enum.Enum):
    SUCCESS = <int>c_AREA_EXPORTING_STATE.AREA_EXPORTING_STATE_SUCCESS
    RUNNING = <int>c_AREA_EXPORTING_STATE.RUNNING
    NOT_STARTED = <int>c_AREA_EXPORTING_STATE.NOT_STARTED
    FILE_EMPTY = <int>c_AREA_EXPORTING_STATE.FILE_EMPTY
    FILE_ERROR = <int>c_AREA_EXPORTING_STATE.FILE_ERROR
    SPATIAL_MEMORY_DISABLED = <int>c_AREA_EXPORTING_STATE.SPATIAL_MEMORY_DISABLED
    LAST = <int>c_AREA_EXPORTING_STATE.AREA_EXPORTING_STATE_LAST

    def __str__(self):
        return to_str(toString(<c_AREA_EXPORTING_STATE>(<unsigned int>self.value))).decode()

    def __repr__(self):
        return to_str(toString(<c_AREA_EXPORTING_STATE>(<unsigned int>self.value))).decode()

##
# Defines which type of position matrix is used to store camera path and pose.
# \ingroup PositionalTracking_group
#
# | Enumerator |                         |
# |------------|-------------------------|
# | WORLD | The transform of sl.Pose will contains the motion with reference to the world frame (previously called PATH). |
# | CAMERA | The transform of sl::Pose will contains the motion with reference to the previous camera frame (previously called POSE). |
class REFERENCE_FRAME(enum.Enum):
    WORLD = <int>c_REFERENCE_FRAME.WORLD
    CAMERA = <int>c_REFERENCE_FRAME.CAMERA
    LAST = <int>c_REFERENCE_FRAME.REFERENCE_FRAME_LAST

    def __str__(self):
        return to_str(toString(<c_REFERENCE_FRAME>(<unsigned int>self.value))).decode()

    def __repr__(self):
        return to_str(toString(<c_REFERENCE_FRAME>(<unsigned int>self.value))).decode()

##
# Lists specific and particular timestamps
#
# \ingroup Video_group
#
# | Enumerator |                         |
# |------------|-------------------------|
# | IMAGE | Defines the timestamp at the time the frame has been extracted from USB stream. |
# | CURRENT | Defines the timestamp at the time of the function call. |
class TIME_REFERENCE(enum.Enum):
    IMAGE = <int>c_TIME_REFERENCE.TIME_REFERENCE_IMAGE
    CURRENT = <int>c_TIME_REFERENCE.CURRENT
    LAST = <int>c_TIME_REFERENCE.TIME_REFERENCE_LAST

    def __str__(self):
        return to_str(toString(<c_TIME_REFERENCE>(<unsigned int>self.value))).decode()

    def __repr__(self):
        return to_str(toString(<c_TIME_REFERENCE>(<unsigned int>self.value))).decode()

##
# Gives the spatial mapping state.
# \ingroup SpatialMapping_group
#
# | Enumerator |                         |
# |------------|-------------------------|
# | INITIALIZING | The spatial mapping is initializing. |
# | OK | The depth and tracking data were correctly integrated in the fusion algorithm. |
# | NOT_ENOUGH_MEMORY | The maximum memory dedicated to the scanning has been reach, the mesh will no longer be updated. |
# | NOT_ENABLED | Camera.enable_spatial_mapping() wasn't called (or the scanning was stopped and not relaunched). |
# | FPS_TOO_LOW | Effective FPS is too low to give proper results for spatial mapping. Consider using PERFORMANCES parameters (DEPTH_MODE.PERFORMANCE, low camera resolution (VGA,HD720), spatial mapping low resolution) |
class SPATIAL_MAPPING_STATE(enum.Enum):
    INITIALIZING = <int>c_SPATIAL_MAPPING_STATE.INITIALIZING
    OK = <int>c_SPATIAL_MAPPING_STATE.SPATIAL_MAPPING_STATE_OK
    NOT_ENOUGH_MEMORY = <int>c_SPATIAL_MAPPING_STATE.NOT_ENOUGH_MEMORY
    NOT_ENABLED = <int>c_SPATIAL_MAPPING_STATE.NOT_ENABLED
    FPS_TOO_LOW = <int>c_SPATIAL_MAPPING_STATE.SPATIAL_MAPPING_STATE_FPS_TOO_LOW
    LAST = <int>c_SPATIAL_MAPPING_STATE.SPATIAL_MAPPING_STATE_LAST

##
# Lists available compression modes for SVO recording.
# \ingroup Video_group
# sl.SVO_COMPRESSION_MODE.LOSSLESS is an improvement of previous lossless compression (used in ZED Explorer), even if size may be bigger, compression time is much faster.
# | Enumerator |                         |
# |------------|-------------------------|
# | LOSSLESS | PNG/ZSTD (lossless) CPU based compression : avg size = 42% (of RAW). |
# | H264 | H264(H264) GPU based compression : avg size = 1% (of RAW). Requires a NVIDIA GPU |
# | H265 | H265(H265) GPU based compression : avg size = 1% (of raw). Requires a NVIDIA GPU |
class SVO_COMPRESSION_MODE(enum.Enum):
    LOSSLESS = <int>c_SVO_COMPRESSION_MODE.LOSSLESS
    H264 = <int>c_SVO_COMPRESSION_MODE.H264
    H265 = <int>c_SVO_COMPRESSION_MODE.H265
    LAST = <int>c_SVO_COMPRESSION_MODE.SVO_COMPRESSION_MODE_LAST

    def __str__(self):
        return to_str(toString(<c_SVO_COMPRESSION_MODE>(<unsigned int>self.value))).decode()

    def __repr__(self):
        return to_str(toString(<c_SVO_COMPRESSION_MODE>(<unsigned int>self.value))).decode()

##
# List available memory type.
# \ingroup Core_group
#
# | Enumerator |                         |
# |------------|-------------------------|
# | CPU | CPU Memory (Processor side). |
# | GPU | GPU Memory (Graphic card side). |
class MEM(enum.Enum):
    CPU = <int>c_MEM.CPU
    GPU = <int>c_MEM.GPU

##
# List available copy operation on \ref Mat .
# \ingroup Core_group
#
# | Enumerator |                         |
# |------------|-------------------------|
# | CPU_CPU | copy data from CPU to CPU. |
# | CPU_GPU | copy data from CPU to GPU. |
# | GPU_GPU | copy data from GPU to GPU. |
# | GPU_CPU | copy data from GPU to CPU. |
class COPY_TYPE(enum.Enum):
    CPU_CPU = <int>c_COPY_TYPE.CPU_CPU
    CPU_GPU = <int>c_COPY_TYPE.CPU_GPU
    GPU_GPU = <int>c_COPY_TYPE.GPU_GPU
    GPU_CPU = <int>c_COPY_TYPE.GPU_CPU

##
# List available \ref Mat formats.
# \ingroup Core_group
#
# | Enumerator |                         |
# |------------|-------------------------|
# | F32_C1 | float 1 channel. |
# | F32_C2 | float 2 channels. |
# | F32_C3 | float 3 channels. |
# | F32_C4 | float 4 channels. |
# | U8_C1 | unsigned char 1 channel. |
# | U8_C2 | unsigned char 2 channels. |
# | U8_C3 | unsigned char 3 channels. |
# | U8_C4 | unsigned char 4 channels. |
class MAT_TYPE(enum.Enum):
    F32_C1 = <int>c_MAT_TYPE.F32_C1
    F32_C2 = <int>c_MAT_TYPE.F32_C2
    F32_C3 = <int>c_MAT_TYPE.F32_C3
    F32_C4 = <int>c_MAT_TYPE.F32_C4
    U8_C1 = <int>c_MAT_TYPE.U8_C1
    U8_C2 = <int>c_MAT_TYPE.U8_C2
    U8_C3 = <int>c_MAT_TYPE.U8_C3
    U8_C4 = <int>c_MAT_TYPE.U8_C4


##
# Lists available object class
#
# \ingroup Object_group
# 
# | Enumerator |                         |
# |------------|-------------------------|
# | PERSON | For people detection |
# | VEHICLE | For vehicles detection. It can be cars, trucks, buses, motorcycles etc |
class OBJECT_CLASS(enum.Enum):
    PERSON = <int>c_OBJECT_CLASS.PERSON
    VEHICLE = <int>c_OBJECT_CLASS.VEHICLE
    LAST = <int>c_OBJECT_CLASS.OBJECT_CLASS_LAST

    def __str__(self):
        return to_str(toString(<c_OBJECT_CLASS>(<unsigned int>self.value))).decode()

    def __repr__(self):
        return to_str(toString(<c_OBJECT_CLASS>(<unsigned int>self.value))).decode()

##
# Lists available object tracking state
#
# \ingroup Object_group
#
# | Enumerator |                         |
# |------------|-------------------------|
# | OFF | The tracking is not yet initialized, the object ID is not usable |
# | OK | The object is tracked |
# | SEARCHING | The object couldn't be detected in the image and is potentially occluded, the trajectory is estimated |
# | TERMINATE | This is the last searching state of the track, the track will be deleted in the next retrieve_object |
class OBJECT_TRACKING_STATE(enum.Enum):
    OFF = <int>c_OBJECT_TRACKING_STATE.OBJECT_TRACKING_STATE_OFF
    OK = <int>c_OBJECT_TRACKING_STATE.OBJECT_TRACKING_STATE_OK
    SEARCHING = <int>c_OBJECT_TRACKING_STATE.OBJECT_TRACKING_STATE_SEARCHING
    TERMINATE = <int>c_OBJECT_TRACKING_STATE.TERMINATE
    LAST = <int>c_OBJECT_TRACKING_STATE.OBJECT_TRACKING_STATE_LAST

    def __str__(self):
        return to_str(toString(<c_OBJECT_TRACKING_STATE>(<unsigned int>self.value))).decode()

    def __repr__(self):
        return to_str(toString(<c_OBJECT_TRACKING_STATE>(<unsigned int>self.value))).decode()

##
# Lists available object action state
#
# \ingroup Object_group
# 
# | Enumerator |                         |
# |------------|-------------------------|
# | IDLE | The object is staying static. |
# | MOVING | The object is moving. |
class OBJECT_ACTION_STATE(enum.Enum):
    IDLE = <int>c_OBJECT_ACTION_STATE.IDLE
    MOVING = <int>c_OBJECT_ACTION_STATE.OBJECT_ACTION_STATE_MOVING
    LAST = <int>c_OBJECT_ACTION_STATE.OBJECT_ACTION_STATE_LAST

    def __str__(self):
        return to_str(toString(<c_OBJECT_ACTION_STATE>(<unsigned int>self.value))).decode()

    def __repr__(self):
        return to_str(toString(<c_OBJECT_ACTION_STATE>(<unsigned int>self.value))).decode()


##
# Contains data of a detected object such as its bounding_box, label, id and its 3D position.
# \ingroup Object_group
cdef class ObjectData:
    cdef c_ObjectData object_data

    ##
    # Object identification number, used as a reference when tracking the object through the frames.
    @property
    def id(self):
        return self.object_data.id

    @id.setter
    def id(self, uint id):
        self.object_data.id = id

    ##
    # Object label. Identify the object type
    @property
    def label(self):
        return OBJECT_CLASS(<int>self.object_data.label)

    @label.setter
    def label(self, label):
        if isinstance(label, OBJECT_CLASS):
            self.object_data.label = <c_OBJECT_CLASS>(<unsigned int>label)
        else:
            raise TypeError("Argument is not of OBJECT_CLASS type.")

    ##
    # Defines the object tracking state.
    @property
    def tracking_state(self):
        return OBJECT_TRACKING_STATE(<int>self.object_data.tracking_state)

    @tracking_state.setter
    def tracking_state(self, tracking_state):
        if isinstance(tracking_state, OBJECT_TRACKING_STATE):
            self.object_data.tracking_state = <c_OBJECT_TRACKING_STATE>(<unsigned int>tracking_state)
        else:
            raise TypeError("Argument is not of OBJECT_TRACKING_STATE type.")

    ##
    # Defines the object action state.
    @property
    def action_state(self):
        return OBJECT_ACTION_STATE(<int>self.object_data.action_state)

    @action_state.setter
    def action_state(self, action_state):
        if isinstance(action_state, OBJECT_ACTION_STATE):
            self.object_data.action_state = <c_OBJECT_ACTION_STATE>(<unsigned int>action_state)
        else:
            raise TypeError("Argument is not of OBJECT_ACTION_STATE type.")

    ##
    # Defines the object 3D centroid in the reference frame selected \ref RuntimeParameters.measure3D_reference_frame and given to the meth \ref Camera.grab() function.
    @property
    def position(self):
        cdef np.ndarray position = np.zeros(3)
        for i in range(3):
            position[i] = self.object_data.position[i]
        return position

    @position.setter
    def position(self, np.ndarray position):
        for i in range(3):
            self.object_data.position[i] = position[i]

    ##
    # Defines the object 3D velocity
    @property
    def velocity(self):
        cdef np.ndarray velocity = np.zeros(3)
        for i in range(3):
            velocity[i] = self.object_data.velocity[i]
        return velocity

    @velocity.setter
    def velocity(self, np.ndarray velocity):
        for i in range(3):
            self.object_data.velocity[i] = velocity[i]

    ##
    # 3D bounding box of the person represented as eight 3D points
    @property
    def bounding_box(self):
        cdef np.ndarray arr = np.zeros((self.object_data.bounding_box.size(), 3), dtype=np.float32)
        for i in range(self.object_data.bounding_box.size()):
            for j in range(3):
                arr[i,j] = self.object_data.bounding_box[i].ptr()[j]
        return arr

    ##
    # 2D bounding box of the person represented as four 2D points starting at the top left corner and rotation clockwise.
    @property
    def bounding_box_2d(self):
        cdef np.ndarray arr = np.zeros((self.object_data.bounding_box_2d.size(), 2))
        for i in range(self.object_data.bounding_box_2d.size()):
            for j in range(2):
                arr[i,j] = self.object_data.bounding_box_2d[i].ptr()[j]
        return arr

    ##
    # Defines the detection confidence value of the object.
    # A lower confidence value means the object might not be localized perfectly or the label (OBJECT_CLASS) is uncertain.
    @property
    def confidence(self):
        return self.object_data.confidence

    @confidence.setter
    def confidence(self, float confidence):
        self.object_data.confidence = confidence

    ##
    # Defines for the bounding_box_2d the pixels which really belong to the object (set to 255) and those of the background (set to 0).
    # \warning The mask information is available only for tracked objects that have a valid depth.
    @property
    def mask(self):
        mat = Mat()
        mat.mat = self.object_data.mask
        return mat

    @mask.setter
    def mask(self, Mat mat):
        self.object_data.mask = mat.mat

    @property
    def dimensions(self):
        cdef np.ndarray dimensions = np.zeros(3)
        for i in range(3):
            dimensions[i] = self.object_data.dimensions[i]
        return dimensions

    @dimensions.setter
    def dimensions(self, np.ndarray dimensions):
        for i in range(3):
            self.object_data.dimensions[i] = dimensions[i]


##
# Contains the result of the object detection module.
# \ingroup Object_group
# The detected objects are listed in \ref object_list
cdef class Objects:
    cdef c_Objects objects

    ##
    # Defines the \ref Timestamp corresponding to the frame acquisition. 
    # This value is especially useful for the async mode to synchronize the data.
    @property
    def timestamp(self):
        ts = Timestamp()
        ts.timestamp=self.objects.timestamp
        return ts

    @timestamp.setter
    def timestamp(self, unsigned long long timestamp):
        self.objects.timestamp.data_ns = timestamp

    ##
    # The list of detected objects. An array of \ref ObjectData .
    @property
    def object_list(self):
        object_list_ = []
        for i in range(self.objects.object_list.size()):
            py_objectData = ObjectData()
            py_objectData.object_data = self.objects.object_list[i]
            object_list_.append(py_objectData)
        return object_list_

    ##
    # Define if the object list has already been retrieved or not.
    @property
    def is_new(self):
        return self.objects.is_new

    @is_new.setter
    def is_new(self, bool is_new):
        self.objects.is_new = is_new

    ##
    # Defined if both the object tracking and the world orientation has been setup.
    @property
    def is_tracked(self):
        return self.objects.is_tracked

    @is_tracked.setter
    def is_tracked(self, bool is_tracked):
        self.objects.is_tracked = is_tracked


    ##
    # Function that look for a given object ID in the current object list and return the object associated if found and a status.
    # \param py_object_data [out] : the object corresponding to the given ID if found
    # \param object_data_id [in] : the input object ID
    # \return True if found False otherwise
    def get_object_data_from_id(self, py_object_data, object_data_id):
        if isinstance(py_object_data, ObjectData) :
            return self.objects.getObjectDataFromId((<ObjectData>py_object_data).object_data, object_data_id)
        else :
           raise TypeError("Argument is not of ObjectData type.") 

##
# Sets the object detection parameters.
# \ingroup Object_group
# The default constructor sets all parameters to their default settings.
# \note Parameters can be user adjusted.
cdef class ObjectDetectionParameters:
    cdef c_ObjectDetectionParameters* object_detection
    def __cinit__(self, image_sync=True, enable_tracking=True, enable_mask_output=True):
            self.object_detection = new c_ObjectDetectionParameters(image_sync, enable_tracking, enable_mask_output)

    def __dealloc__(self):
        del self.object_detection

    ##
    # Defines if the object detection  is synchronized to the image or runs in a separate thread
    @property
    def image_sync(self):
        return self.object_detection.image_sync

    @image_sync.setter
    def image_sync(self, bool image_sync):
        self.object_detection.image_sync = image_sync

    ##
    # Defines if the object detection will track objects across images flow
    @property
    def enable_tracking(self):
        return self.object_detection.enable_tracking

    @enable_tracking.setter
    def enable_tracking(self, bool enable_tracking):
        self.object_detection.enable_tracking = enable_tracking

    @property
    def enable_mask_output(self):
        return self.object_detection.enable_mask_output

    @enable_mask_output.setter
    def enable_mask_output(self, bool enable_mask_output):
        self.object_detection.enable_mask_output = enable_mask_output

##
# Sets the object detection runtime parameters.
# \ingroup Object_group
# \param detection_confidence_threshold : Defines the confidence threshold: interval between 1 and 99.
# \param object_class_filter : An array of \ref OBJECT_CLASS . Defines which object type to detect and track, by default (empty array) everything. Fewer objects type can slightly speed up the process, since every objects are tracked.
cdef class ObjectDetectionRuntimeParameters:
    cdef c_ObjectDetectionRuntimeParameters* object_detection_rt
    def __cinit__(self, detection_confidence_threshold=50, object_class_filter=[]):
        cdef vector[int] vec_cpy
        for object_class in object_class_filter:
            vec_cpy.push_back(<int>object_class.value)
        self.object_detection_rt = create_object_detection_runtime_parameters(detection_confidence_threshold, vec_cpy)

    def __dealloc__(self):
        del self.object_detection_rt

    ##
    # Defines the confidence threshold: interval between 1 and 99. A confidence of 1 meaning a low threshold, more uncertain objects and 99 very few but very precise objects.
    # If the scene contains a lot of objects, increasing the confidence can slightly speed up the process, since every object instances are tracked.
    @property
    def detection_confidence_threshold(self):
        return self.object_detection_rt.detection_confidence_threshold

    @detection_confidence_threshold.setter
    def detection_confidence_threshold(self, bool detection_confidence_threshold):
        self.object_detection_rt.detection_confidence_threshold = detection_confidence_threshold

#   @property
#    def object_class_filter(self):
#        """
#        Defines which object type to detect and track, by default (empty vector) everything.
#        Fewer objects type can slightly speed up the process, since every objects are tracked.
#        """
#        return self.object_detection_rt.object_class_filter


#    @object_class_filter.setter
#    def object_class_filter(self, object_class_filter):
#        self.object_detection_rt.object_class_filter = object_class_filter



# Returns the current timestamp at the time the function is called.
# \ingroup Core_group
def get_current_timestamp():
    ts = Timestamp()
    ts.timestamp = getCurrentTimeStamp()
    return ts


##
# Width and height of an array.
# \ingroup Core_group
cdef class Resolution:
    cdef c_Resolution resolution
    def __cinit__(self, width=0, height=0):
        self.resolution.width = width
        self.resolution.height = height

    ##
    # Returns the area of the image.
    # \return The number of pixels of the array.
    def py_area(self):
        return self.resolution.width * self.resolution.height

    ##
    # array width in pixels
    @property
    def width(self):
        return self.resolution.width

    @width.setter
    def width(self, value):
        self.resolution.width = value

    ##
    # array height in pixels
    @property
    def height(self):
        return self.resolution.height

    @height.setter
    def height(self, value):
        self.resolution.height = value

    def __richcmp__(Resolution left, Resolution right, int op):
        if op == 2:
            return left.width==right.width and left.height==right.height
        if op == 3:
            return left.width!=right.width or left.height!=right.height
        else:
            raise NotImplementedError()

##
# Intrinsic parameters of a camera.
# \ingroup Depth_group
# Those information about the camera will be returned by \ref Camera.get_camera_information() .
# \note Similar to the \ref CalibrationParameters , those parameters are taken from the settings file (SNXXX.conf) and are modified during the \ref Camera.open call, represent the camera matrix corresponding to rectified or unrectified images. \nWhen filled with rectified parameters, fx,fy,cx,cy must be the same for Left and Right \ref Camera once \ref Camera.open has been called. Since distortion is corrected during rectification, distortion should not be considered on rectified images.
cdef class CameraParameters:
    cdef c_CameraParameters camera_params
    ##
    # Focal length in pixels along x axis.
    @property
    def fx(self):
        return self.camera_params.fx

    @fx.setter
    def fx(self, float fx_):
        self.camera_params.fx = fx_

    ##
    # Focal length in pixels along y axis.
    @property
    def fy(self):
        return self.camera_params.fy

    @fy.setter
    def fy(self, float fy_):
        self.camera_params.fy = fy_

    ##
    # Optical center along x axis, defined in pixels (usually close to width/2).
    @property
    def cx(self):
        return self.camera_params.cx

    @cx.setter
    def cx(self, float cx_):
        self.camera_params.cx = cx_

    ##
    # Optical center along y axis, defined in pixels (usually close to height/2).
    @property
    def cy(self):
        return self.camera_params.cy

    @cy.setter
    def cy(self, float cy_):
        self.camera_params.cy = cy_

    ##
    # A Numpy array. Distortion factor : [ k1, k2, p1, p2, k3 ]. Radial (k1,k2,k3) and Tangential (p1,p2) distortion.
    @property
    def disto(self):
        cdef np.ndarray arr = np.zeros(5)
        for i in range(5):
            arr[i] = self.camera_params.disto[i]
        return arr

    ##
    # Sets the elements of the disto array.
    # \param float value1 : k1
    # \param float value2 : k2
    # \param float value3 : p1
    # \param float value4 : p2
    # \param float value5 : k3
    def set_disto(self, float value1, float value2, float value3, float value4, float value5):
        self.camera_params.disto[0] = value1
        self.camera_params.disto[1] = value2
        self.camera_params.disto[2] = value3
        self.camera_params.disto[3] = value4
        self.camera_params.disto[4] = value5

    ##
    # Vertical field of view, in degrees.
    @property
    def v_fov(self):
        return self.camera_params.v_fov

    @v_fov.setter
    def v_fov(self, float v_fov_):
        self.camera_params.v_fov = v_fov_

    ##
    # Horizontal field of view, in degrees.
    @property
    def h_fov(self):
        return self.camera_params.h_fov

    @h_fov.setter
    def h_fov(self, float h_fov_):
        self.camera_params.h_fov = h_fov_

    ##
    # Diagonal field of view, in degrees.
    @property
    def d_fov(self):
        return self.camera_params.d_fov

    @d_fov.setter
    def d_fov(self, float d_fov_):
        self.camera_params.d_fov = d_fov_

    ##
    # size in pixels of the images given by the camera.
    @property
    def image_size(self):
        return Resolution(self.camera_params.image_size.width, self.camera_params.image_size.height)

    @image_size.setter
    def image_size(self, Resolution size_):
        self.camera_params.image_size.width = size_.width
        self.camera_params.image_size.height = size_.height

    ##
    # Setups the parameter of a camera.
    # size in pixels of the images given by the camera.
    # \param float fx_ : horizontal focal length.
    # \param float fy_ : vertucak focal length.
    # \param float cx_ : horizontal optical center.
    # \param float cx_ : vertical optical center. 
    def set_up(self, float fx_, float fy_, float cx_, float cy_) :
        self.camera_params.fx = fx_
        self.camera_params.fy = fy_
        self.camera_params.cx = cx_
        self.camera_params.cy = cy_


##
# Intrinsic and Extrinsic parameters of the camera (translation and rotation).
# \ingroup Depth_group
# Those information about the camera will be returned by \ref Camera.get_camera_information() .
# \note The calibration/rectification process, called during \ref Camera.open() , is using the raw parameters defined in the SNXXX.conf file, where XXX is the ZED Serial Number.
# \n Those values may be adjusted or not by the Self-Calibration to get a proper image alignment. After \ref Camera.open() is done (with or without Self-Calibration activated) success, most of the stereo parameters (except Baseline of course) should be 0 or very close to 0.
# \n  It means that images after rectification process (given by \ref Camera.retrieve_image() ) are aligned as if they were taken by a "perfect" stereo camera, defined by the new \ref CalibrationParameters .
# \warning \ref CalibrationParameters are returned in \ref COORDINATE_SYSTEM.IMAGE , they are not impacted by the \ref InitParameters.coordinate_system .
cdef class CalibrationParameters:
    cdef c_CalibrationParameters calibration
    cdef CameraParameters py_left_cam
    cdef CameraParameters py_right_cam
    cdef Vector3[float] R
    cdef Vector3[float] T

    def __cinit__(self):
        self.py_left_cam = CameraParameters()
        self.py_right_cam = CameraParameters()

    def set(self):
        self.py_left_cam.camera_params = self.calibration.left_cam
        self.py_right_cam.camera_params = self.calibration.right_cam
        self.R = self.calibration.R
        self.T = self.calibration.T

    ##
    # Rotation on its own (using Rodrigues' transformation) of the right sensor. The left is considered as the reference. Defined as 'tilt', 'convergence' and 'roll'. Using a \ref Rotation , you can use \ref Rotation.set_rotation_vector() to convert into other representations.
    # \n Returns a Numpy array of float.
    @property
    def R(self):
        cdef np.ndarray arr = np.zeros(3)
        for i in range(3):
            arr[i] = self.calibration.R[i]
        return arr

    ##
    # Sets \ref R 's data.
    # \param float value1 : x
    # \param float value2 : y
    # \param float value3 : z
    def set_R(self, float value1, float value2, float value3) :
        self.calibration.R[0] = value1
        self.calibration.R[1] = value2
        self.calibration.R[3] = value3
        self.set()

    ##
    # Translation between the two sensors. T[0] is the distance between the two cameras (baseline) in the \ref UNIT chosen during \ref Camera.open (mm, cm, meters, inches...).
    # \n Returns a numpy array of float.
    @property
    def T(self):
        cdef np.ndarray arr = np.zeros(3)
        for i in range(3):
            arr[i] = self.calibration.T[i]
        return arr

    ##
    # Sets \ref T 's data.
    # \param float value1 : x
    # \param float value2 : y
    # \param float value3 : z
    def set_T(self, float value1, float value2, float value3) :
        self.calibration.T[0] = value1
        self.calibration.T[1] = value2
        self.calibration.T[2] = value3
        self.set()

    ##
    # Intrisics \ref CameraParameters of the left camera.
    @property
    def left_cam(self):
        return self.py_left_cam

    @left_cam.setter
    def left_cam(self, CameraParameters left_cam_) :
        self.calibration.left_cam = left_cam_.camera_params
        self.set()
    
    ##
    # Intrisics \ref CameraParameters of the right camera.
    @property
    def right_cam(self):
        return self.py_right_cam

    @right_cam.setter
    def right_cam(self, CameraParameters right_cam_) :
        self.calibration.right_cam = right_cam_.camera_params
        self.set()


##
# Structure containing information of a signle camera (serial number, model, calibration, etc.)
# \ingroup Video_group
# Those information about the camera will be returned by \ref Camera.get_camera_information()
# \note This object is meant to be used as a read-only container, editing any of its field won't impact the SDK.
# \warning \ref CalibrationParameters are returned in \ref COORDINATE_SYSTEM.IMAGE , they are not impacted by the \ref InitParameters.coordinate_system
cdef class CameraInformation:
    cdef CalibrationParameters py_calib
    cdef CalibrationParameters py_calib_raw
    cdef unsigned int serial_number
    cdef unsigned int camera_firmware_version
    cdef unsigned int sensors_firmware_version
    cdef c_MODEL camera_model
    cdef Transform py_camera_imu_transform
    cdef c_Resolution py_res
    cdef float camera_fps

    ##
    # Constructor. Gets the \ref CameraParameters from a \ref Camera object.
    # \param py_camera : \ref Camera object.
    # \param resizer : You can specify a \ref Resolution different from default image size to get the scaled camera information. default = (0,0) meaning original image size.
    #
    # \code
    # cam = sl.Camera()
    # res = sl.Resolution(0,0)
    # cam_info = sl.CameraInformation(cam, res)
    # \endcode
    def __cinit__(self, Camera py_camera, Resolution resizer=Resolution(0,0)):
        res = c_Resolution(resizer.width, resizer.height)
        self.py_calib = CalibrationParameters()
        self.py_calib.calibration = py_camera.camera.getCameraInformation(res).calibration_parameters
        self.py_calib_raw = CalibrationParameters()
        self.py_calib_raw.calibration = py_camera.camera.getCameraInformation(res).calibration_parameters_raw
        self.py_calib.set()
        self.py_calib_raw.set()
        self.py_camera_imu_transform = Transform()
        self.py_camera_imu_transform.transform = py_camera.camera.getCameraInformation(res).camera_imu_transform
        self.serial_number = py_camera.camera.getCameraInformation(res).serial_number
        self.camera_firmware_version = py_camera.camera.getCameraInformation(res).camera_firmware_version
        self.sensors_firmware_version = py_camera.camera.getCameraInformation(res).sensors_firmware_version
        self.camera_model = py_camera.camera.getCameraInformation(res).camera_model
        self.py_res = py_camera.camera.getCameraInformation(res).camera_resolution
        self.camera_fps = py_camera.camera.getCameraInformation(res).camera_fps

    ##
    # \ref Resolution of the camera
    @property
    def camera_resolution(self):
        return Resolution(self.py_res.width, self.py_res.height)

    ##
    # \ref FPS of the camera
    @property
    def camera_fps(self):
        return self.camera_fps

    ##
    # The model of the camera (ZED, ZED2 or ZED-M).
    @property
    def camera_model(self):
        return MODEL(<int>self.camera_model)

    ##
    # Intrinsic and Extrinsic stereo \ref CalibrationParameters for rectified/undistorded images (default).
    @property
    def calibration_parameters(self):
        return self.py_calib

    ##
    # Intrinsic and Extrinsic stereo \ref CalibrationParameters for original images (unrectified/distorded).
    @property
    def calibration_parameters_raw(self):
        return self.py_calib_raw

    ##
    # IMU to Left camera transform matrix, that contains rotation and translation between IMU frame and camera frame. Note that this transform was applied to the fused quaternion provided in get_imu_data() in v2.4 but not anymore starting from v2.5. See \ref Camera.get_sensors_data() for more info.
    @property
    def camera_imu_transform(self):
        return self.py_camera_imu_transform

    ##
    # The serial number of the camera.
    @property
    def serial_number(self):
        return self.serial_number

    ##
    # The internal firmware version of the camera.
    @property
    def camera_firmware_version(self):
        return self.camera_firmware_version

    ##
    # The internal firmware version of the sensors of ZEDM or ZED2.
    @property
    def sensors_firmware_version(self):
        return self.sensors_firmware_version


##
# The \ref Mat class can handle multiple matrix format from 1 to 4 channels, with different value types (float or uchar), and can be stored CPU and/or GPU side.
# \ingroup Core_group
#
# \ref Mat is defined in a row-major order, it means that, for an image buffer, the entire first row is stored first, followed by the entire second row, and so on.
#
# The CPU and GPU buffer aren't automatically synchronized for performance reasons, you can use \ref update_gpu_from_cpu / \ref update_gpu_from_cpu to do it. If you are using the GPU side of the \ref Mat object, you need to make sure to call free before destroying the \ref Camera object. The destruction of the \ref Camera object deletes the CUDA context needed to free the \ref Mat memory.
cdef class Mat:
    cdef c_Mat mat
    ##
    # Constructor.
    # \param width : width of the matrix in pixels.
    # \param height : height of the matrix in pixels.
    # \param mat_type : the type of the matrix (\ref MAT_TYPE.F32_C1 , \ref MAT_TYPE.U8_C4 ...)
    # \param memory_type : defines where the buffer will be stored (\ref MEM.MEM_CPU and/or \ref MEM.MEM_GPU)
    #
    # \code
    # mat = sl.Mat(width=0, height=0, mat_type=MAT_TYPE.F32_C1, memory_type=MEM.CPU)
    # \endcode
    def __cinit__(self, width=0, height=0, mat_type=MAT_TYPE.F32_C1, memory_type=MEM.CPU):
        c_Mat(width, height, <c_MAT_TYPE>(<unsigned int>mat_type.value), <c_MEM>(<unsigned int>memory_type.value)).move(self.mat)

    ##
    # Inits a new \ref Mat .
    # This function directly allocates the requested memory. It calls \ref alloc_size .
    # \param width : width of the matrix in pixels.
    # \param height : height of the matrix in pixels.
    # \param mat_type : the type of the matrix (\ref MAT_TYPE.F32_C1 , \ref MAT_TYPE.U8_C4 ...)
    # \param memory_type : defines where the buffer will be stored (\ref MEM.MEM_CPU and/or \ref MEM.MEM_GPU)
    def init_mat_type(self, width, height, mat_type, memory_type=MEM.CPU):
        if isinstance(mat_type, MAT_TYPE) and isinstance(memory_type, MEM):
            c_Mat(width, height, <c_MAT_TYPE>(<unsigned int>mat_type.value), <c_MEM>(<unsigned int>memory_type.value)).move(self.mat)
        else:
            raise TypeError("Argument are not of MAT_TYPE or MEM type.")

    ##
    # Inits a new \ref Mat from an existing data pointer.
    # This function doesn't allocate the memory.
    # \param width : width of the matrix in pixels.
    # \param height : height of the matrix in pixels.
    # \param mat_type : the type of the matrix (\ref MAT_TYPE.F32_C1 , \ref MAT_TYPE.U8_C4 ...)
    # \param ptr : pointer to the data array. (CPU or GPU).
    # \param step : step of the data array. (the Bytes size of one pixel row).
    # \param memory_type : defines where the buffer will be stored (\ref MEM.MEM_CPU and/or \ref MEM.MEM_GPU )
    def init_mat_cpu(self, width, height, mat_type, ptr, step, memory_type=MEM.CPU):
        if isinstance(mat_type, MAT_TYPE) and isinstance(memory_type, MEM):
            c_Mat(width, height, <c_MAT_TYPE>(<unsigned int>mat_type.value), ptr.encode(), step, <c_MEM>(<unsigned int>memory_type.value)).move(self.mat)
        else:
            raise TypeError("Argument are not of MAT_TYPE or MEM type.")

    ##
    # Inits a new \ref Mat from two existing data pointers, CPU and GPU.
    # This function doesn't allocate the memory.
    # \param width : width of the matrix in pixels.
    # \param height : height of the matrix in pixels.
    # \param mat_type : the type of the matrix (\ref MAT_TYPE.F32_C1 , \ref MAT_TYPE.U8_C4 ...)
    # \param ptr_cpu : pointer to the CPU data array.
    # \param step_cpu : step of the CPU data array. (the Bytes size of one pixel row).
    # \param ptr_gpu : pointer to the GPU data array.
    # \param step_gpu : step of the GPU data array. (the Bytes size of one pixel row).
    def init_mat_cpu_gpu(self, width, height, mat_type, ptr_cpu, step_cpu, ptr_gpu, step_gpu):
        if isinstance(mat_type, MAT_TYPE):
             c_Mat(width, height, <c_MAT_TYPE>(<unsigned int>mat_type.value), ptr_cpu.encode(), step_cpu, ptr_gpu.encode(), step_gpu).move(self.mat)
        else:
            raise TypeError("Argument is not of MAT_TYPE type.")

    ##
    # Inits a new \ref Mat .
    # This function directly allocates the requested memory. It calls \ref alloc_resolution .
    # \param resolution : the size of the matrix in pixels.
    # \param mat_type : the type of the matrix (\ref MAT_TYPE.F32_C1 , \ref MAT_TYPE.U8_C4 )
    # \param memory_type : defines where the buffer will be stored (\ref MEM.MEM_CPU and/or \ref MEM.MEM_GPU )
    def init_mat_resolution(self, Resolution resolution, mat_type, memory_type):
        if isinstance(mat_type, MAT_TYPE) and isinstance(memory_type, MEM):
            c_Mat(c_Resolution(resolution.width, resolution.height), <c_MAT_TYPE>(<unsigned int>mat_type.value), <c_MEM>(<unsigned int>memory_type.value)).move(self.mat)
        else:
            raise TypeError("Argument are not of MAT_TYPE or MEM type.")

    ##
    # Inits a new \ref Mat from an existing data pointer.
    # This function doesn't allocate the memory.
    # \param resolution : the size of the matrix in pixels.
    # \param mat_type : the type of the matrix (\ref MAT_TYPE.F32_C1 , \ref MAT_TYPE.U8_C4 ...)
    # \param ptr : pointer to the data array. (CPU or GPU).
    # \param step : step of the data array. (the Bytes size of one pixel row).
    # \param memory_type : defines where the buffer will be stored (\ref MEM.MEM_CPU and/or \ref MEM.MEM_GPU )
    def init_mat_resolution_cpu(self, Resolution resolution, mat_type, ptr, step, memory_type=MEM.CPU):
        if isinstance(mat_type, MAT_TYPE) and isinstance(memory_type, MEM):
            c_Mat(c_Resolution(resolution.width, resolution.height), <c_MAT_TYPE>(<unsigned int>mat_type.value), ptr.encode(), step, <c_MEM>(<unsigned int>memory_type.value)).move(self.mat)
        else:
            raise TypeError("Argument are not of MAT_TYPE or MEM type.")
    ##
    # Inits a new \ref Mat from two existing data pointers, CPU and GPU.
    # This function doesn't allocate the memory.
    # \param resolution : the size of the matrix in pixels.
    # \param mat_type : the type of the matrix (\ref MAT_TYPE.F32_C1 , \ref MAT_TYPE.U8_C4 ...)
    # \param ptr_cpu : pointer to the CPU data array.
    # \param step_cpu : step of the CPU data array. (the Bytes size of one pixel row).
    # \param ptr_gpu : pointer to the GPU data array.
    # \param step_gpu : step of the GPU data array. (the Bytes size of one pixel row).
    def init_mat_resolution_cpu_gpu(self, Resolution resolution, mat_type, ptr_cpu, step_cpu, ptr_gpu, step_gpu):
        if isinstance(mat_type, MAT_TYPE):
             matResolution(c_Resolution(resolution.width, resolution.height), <c_MAT_TYPE>(<unsigned int>mat_type.value), ptr_cpu.encode(), step_cpu, ptr_gpu.encode(), step_gpu).move(self.mat)
        else:
            raise TypeError("Argument is not of MAT_TYPE type.")

    ##
    # Inits a new \ref Mat by copy (shallow copy).
    # This function doesn't allocate the memory.
    # \param mat : a \ref Mat to copy.
    def init_mat(self, Mat matrix):
        c_Mat(matrix.mat).move(self.mat)

    ##
    # Allocates the \ref Mat memory.
    # \param width : width of the matrix in pixels.
    # \param height : height of the matrix in pixels.
    # \param mat_type : the type of the matrix (\ref MAT_TYPE.F32_C1 , \ref MAT_TYPE.U8_C4 ...)
    # \param memory_type : defines where the buffer will be stored (\ref MEM.MEM_CPU and/or \ref MEM.MEM_GPU )
    #
    # \warning It erases previously allocated memory.
    def alloc_size(self, width, height, mat_type, memory_type=MEM.CPU):
        if isinstance(mat_type, MAT_TYPE) and isinstance(memory_type, MEM):
            self.mat.alloc(<size_t> width, <size_t> height, <c_MAT_TYPE>(<unsigned int>mat_type.value), <c_MEM>(<unsigned int>memory_type.value))
        else:
            raise TypeError("Arguments must be of Mat and MEM types.")

    ##
    # Allocates the \ref Mat memory.
    # \param resolution : the size of the matrix in pixels.
    # \param mat_type : the type of the matrix (\ref MAT_TYPE.F32_C1 , \ref MAT_TYPE.U8_C4 ...)
    # \param memory_type : defines where the buffer will be stored (\ref MEM.MEM_CPU and/or \ref MEM.MEM_GPU )
    #
    # \warning It erases previously allocated memory.
    def alloc_resolution(self, Resolution resolution, mat_type, memory_type=MEM.CPU):
        if isinstance(mat_type, MAT_TYPE) and isinstance(memory_type, MEM):
            self.mat.alloc(resolution.width, resolution.height, <c_MAT_TYPE>(<unsigned int>mat_type.value), <c_MEM>(<unsigned int>memory_type.value))
        else:
            raise TypeError("Arguments must be of Mat and MEM types.")

    ##
    # Free the owned memory.
    # \param memory_type : specify whether you want to free the \param MEM.CPU and/or \data MEM.GPU memory. If None it frees both CPU and GPU memory.
    def free(self, memory_type=None):
        if isinstance(memory_type, MEM):
            self.mat.free(<c_MEM>(<unsigned int>memory_type.value))
        elif memory_type is None:
            self.mat.free(<c_MEM>(<unsigned int>(MEM.CPU or MEM.GPU)))
        else:
            raise TypeError("Argument is not of MEM type.")

    ##
    # Downloads data from DEVICE (GPU) to HOST (CPU), if possible.
    # \return \ref ERROR_CODE.SUCCESS if everything went well, \ref ERROR_CODE.FAILURE otherwise.
    #
    # \note If no CPU or GPU memory are available for this \ref Mat , some are directly allocated. If verbose sets, you have informations in case of failure.
    def update_cpu_from_gpu(self):
        return ERROR_CODE(<int>self.mat.updateCPUfromGPU())

    ##
    # Downloads data from DEVICE (CPU) to HOST (GPU), if possible.
    # \return \ref ERROR_CODE.SUCCESS if everything went well, \ref ERROR_CODE.FAILURE otherwise.
    #
    # \note If no CPU or GPU memory are available for this \ref Mat , some are directly allocated.If verbose set, you have informations in case of failure.
    def update_gpu_from_cpu(self):
        return ERROR_CODE(<int>self.mat.updateGPUfromCPU())

    ##
    # Copies data to another \ref Mat (deep copy).
    #
    # \param dst : the \ref Mat where the data will be copied.
    # \param cpy_type : specify the memories that will be used for the copy.
    # \return The dst \ref Mat
    #
    # \note If the destination is not allocated or has a not a compatible \ref MAT_TYPE or \ref Resolution , current memory is freed and new memory is directly allocated.
    def copy_to(self, Mat dst=Mat(), cpy_type=COPY_TYPE.CPU_CPU):
        self.mat.copyTo(dst.mat, <c_COPY_TYPE>(<unsigned int>cpy_type.value))
        return dst

    ##
    # Copies data from an other \ref Mat (deep copy).
    # \param src : the \ref Mat where the data will be copied from.
    # \param cpy_type : specify the memories that will be used for the update.
    # \return \ref ERROR_CODE.SUCCESS if everything went well, \ref ERROR_CODE.FAILURE otherwise.
    #
    # \note If the current \ref Mat or has a not a compatible \ref MAT_TYPE or \ref Resolution with the source, current memory is freed and new memory is directly allocated.
    def set_from(self, Mat src=Mat(), cpy_type=COPY_TYPE.CPU_CPU):
        return ERROR_CODE(<int>self.mat.setFrom(<const c_Mat>src.mat, <c_COPY_TYPE>(<unsigned int>cpy_type.value)))

    ##
    # Reads an image from a file (only if \ref MEM.CPU is available on the current \ref Mat ).
    # Supported input files format are PNG and JPEG.
    # \param filepath : file path including the name and extension
    # \return \ref ERROR_CODE.SUCCESS if everything went well, \ref ERROR_CODE.FAILURE otherwise.
    #
    # \note Supported \ref MAT_TYPE are \ref MAT_TYPE.U8_C1 , \ref MAT_TYPE.U8_C3 and \ef MAT_TYPE.U8_C4 .
    def read(self, str filepath):
        return ERROR_CODE(<int>self.mat.read(filepath.encode()))

    ##
    # Writes the \ref Mat (only if \ref MEM.CPU is available on the current \ref Mat ) into a file as an image.
    # Supported output files format are PNG and JPEG.
    # \param filepath : file path including the name and extension.
    # \return \ref ERROR_CODE.SUCCESS if everything went well, \ref ERROR_CODE.FAILURE otherwise.
    #
    # \note Supported \ref MAT_TYPE are \ref MAT_TYPE.U8_C1 , \ref MAT_TYPE.U8_C3 and \ef MAT_TYPE.U8_C4 .
    def write(self, str filepath):
        return ERROR_CODE(<int>self.mat.write(filepath.encode()))

    ##
    # Fills the \ref Mat with the given value.
    # This function overwrites all the matrix.
    # \param value : the value to be copied all over the matrix.
    # \param memory_type : defines which buffer to fill, CPU and/or GPU.
    def set_to(self, value, memory_type=MEM.CPU):
        if <int>self.get_data_type() == MAT_TYPE.U8_C1:
            return ERROR_CODE(<int>setToUchar1(self.mat, value, <c_MEM>(<unsigned int>memory_type.value)))
        elif <int>self.get_data_type() == MAT_TYPE.U8_C2:
            return ERROR_CODE(<int>setToUchar2(self.mat, Vector2[uchar1](value[0], value[1]),
                                      <c_MEM>(<unsigned int>memory_type.value)))
        elif <int>self.get_data_type() == MAT_TYPE.U8_C3:
            return ERROR_CODE(<int>setToUchar3(self.mat, Vector3[uchar1](value[0], value[1],
                                      value[2]), <c_MEM>(<unsigned int>memory_type.value)))
        elif <int>self.get_data_type() == MAT_TYPE.U8_C4:
            return ERROR_CODE(<int>setToUchar4(self.mat, Vector4[uchar1](value[0], value[1], value[2],
                                      value[3]), <c_MEM>(<unsigned int>memory_type.value)))
        elif <int>self.get_data_type() == MAT_TYPE.F32_C1:
            return ERROR_CODE(<int>setToFloat1(self.mat, value, <c_MEM>(<unsigned int>memory_type.value)))
        elif <int>self.get_data_type() == MAT_TYPE.F32_C2:
            return ERROR_CODE(<int>setToFloat2(self.mat, Vector2[float1](value[0], value[1]),
                                      <c_MEM>(<unsigned int>memory_type.value)))
        elif <int>self.get_data_type() == MAT_TYPE.F32_C3:
            return ERROR_CODE(<int>setToFloat3(self.mat, Vector3[float1](value[0], value[1],
                                      value[2]), <c_MEM>(<unsigned int>memory_type.value)))
        elif <int>self.get_data_type() == MAT_TYPE.F32_C4:
            return ERROR_CODE(<int>setToFloat4(self.mat, Vector4[float1](value[0], value[1], value[2],
                                      value[3]), <c_MEM>(<unsigned int>memory_type.value)))

    ##
    # Sets a value to a specific point in the matrix.
    # \param x : specify the column.
    # \param y : specify the row.
    # \param value : the value to be set.
    # \param memory_type : defines which memory will be updated.
    # \return ERROR_CODE.SUCCESS if everything went well, \ref ERROR_CODE.FAILURE otherwise.
    #
    # \warning not efficient for GPU, use it on sparse data.
    def set_value(self, x, y, value, memory_type=MEM.CPU):
        if <int>self.get_data_type() == MAT_TYPE.U8_C1:
            return ERROR_CODE(<int>setValueUchar1(self.mat, x, y, value, <c_MEM>(<unsigned int>memory_type.value)))
        elif <int>self.get_data_type() == MAT_TYPE.U8_C2:
            return ERROR_CODE(<int>setValueUchar2(self.mat, x, y, Vector2[uchar1](value[0], value[1]),
                                      <c_MEM>(<unsigned int>memory_type.value)))
        elif <int>self.get_data_type() == MAT_TYPE.U8_C3:
            return ERROR_CODE(<int>setValueUchar3(self.mat, x, y, Vector3[uchar1](value[0], value[1],
                                      value[2]), <c_MEM>(<unsigned int>memory_type.value)))
        elif <int>self.get_data_type() == MAT_TYPE.U8_C4:
            return ERROR_CODE(<int>setValueUchar4(self.mat, x, y, Vector4[uchar1](value[0], value[1], value[2],
                                      value[3]), <c_MEM>(<unsigned int>memory_type.value)))
        elif <int>self.get_data_type() == MAT_TYPE.F32_C1:
            return ERROR_CODE(<int>setValueFloat1(self.mat, x, y, value, <c_MEM>(<unsigned int>memory_type.value)))
        elif <int>self.get_data_type() == MAT_TYPE.F32_C2:
            return ERROR_CODE(<int>setValueFloat2(self.mat, x, y, Vector2[float1](value[0], value[1]),
                                      <c_MEM>(<unsigned int>memory_type.value)))
        elif <int>self.get_data_type() == MAT_TYPE.F32_C3:
            return ERROR_CODE(<int>setValueFloat3(self.mat, x, y, Vector3[float1](value[0], value[1],
                                      value[2]), <c_MEM>(<unsigned int>memory_type.value)))
        elif <int>self.get_data_type() == MAT_TYPE.F32_C4:
            return ERROR_CODE(<int>setValueFloat4(self.mat, x, y, Vector4[float1](value[0], value[1], value[2],
                                      value[3]), <c_MEM>(<unsigned int>memory_type.value)))

    ##
    # Returns the value of a specific point in the matrix.
    # \param x : specify the column
    # \param y : specify the row
    # \param memory_type : defines which memory should be read.
    # \return ERROR_CODE.SUCCESS if everything went well, \ref ERROR_CODE.FAILURE otherwise.
    #
    # \warning not efficient for GPU, use it on sparse data.
    def get_value(self, x, y, memory_type=MEM.CPU):
        cdef uchar1 value1u
        cdef Vector2[uchar1] value2u = Vector2[uchar1](0,0)
        cdef Vector3[uchar1] value3u = Vector3[uchar1](0,0,0)
        cdef Vector4[uchar1] value4u = Vector4[uchar1](0,0,0,0)

        cdef float1 value1f
        cdef Vector2[float1] value2f = Vector2[float1](0,0)
        cdef Vector3[float1] value3f = Vector3[float1](0,0,0)
        cdef Vector4[float1] value4f = Vector4[float1](0,0,0,0)

        if self.get_data_type() == MAT_TYPE.U8_C1:
            status = getValueUchar1(self.mat, x, y, &value1u, <c_MEM>(<unsigned int>memory_type.value))
            return ERROR_CODE(<int>status), self.get_data()[x, y]
        elif self.get_data_type() == MAT_TYPE.U8_C2:
            status = getValueUchar2(self.mat, x, y, &value2u, <c_MEM>(<unsigned int>memory_type.value))
            return ERROR_CODE(<int>status), np.array([value2u.ptr()[0], value2u.ptr()[1]])
        elif self.get_data_type() == MAT_TYPE.U8_C3:
            status = getValueUchar3(self.mat, x, y, &value3u, <c_MEM>(<unsigned int>memory_type.value))
            return ERROR_CODE(<int>status), np.array([value3u.ptr()[0], value3u.ptr()[1], value3u.ptr()[2]])
        elif self.get_data_type() == MAT_TYPE.U8_C4:
            status = getValueUchar4(self.mat, x, y, &value4u, <c_MEM>(<unsigned int>memory_type.value))
            return ERROR_CODE(<int>status), np.array([value4u.ptr()[0], value4u.ptr()[1], value4u.ptr()[2],
                                                         value4u.ptr()[3]])

        elif self.get_data_type() == MAT_TYPE.F32_C1:
            status = getValueFloat1(self.mat, x, y, &value1f, <c_MEM>(<unsigned int>memory_type.value))
            return ERROR_CODE(<int>status), self.get_data()[x, y]
        elif self.get_data_type() == MAT_TYPE.F32_C2:
            status = getValueFloat2(self.mat, x, y, &value2f, <c_MEM>(<unsigned int>memory_type.value))
            return ERROR_CODE(<int>status), np.array([value2f.ptr()[0], value2f.ptr()[1]])
        elif self.get_data_type() == MAT_TYPE.F32_C3:
            status = getValueFloat3(self.mat, x, y, &value3f, <c_MEM>(<unsigned int>memory_type.value))
            return ERROR_CODE(<int>status), np.array([value3f.ptr()[0], value3f.ptr()[1], value3f.ptr()[2]])
        elif self.get_data_type() == MAT_TYPE.F32_C4:
            status = getValueFloat4(self.mat, x, y, &value4f, <c_MEM>(<unsigned int>memory_type.value))
            return ERROR_CODE(<int>status), np.array([value4f.ptr()[0], value4f.ptr()[1], value4f.ptr()[2],
                                                         value4f.ptr()[3]])

    ##
    # Returns the width of the matrix.
    # \return The width of the matrix in pixels.
    def get_width(self):
        return self.mat.getWidth()

    ##
    # Returns the height of the matrix.
    # \return The height of the matrix in pixels.
    def get_height(self):
        return self.mat.getHeight()

    ##
    # Returns the resolution of the matrix.
    # \return The resolution of the matrix in pixels.
    def get_resolution(self):
        return Resolution(self.mat.getResolution().width, self.mat.getResolution().height)

    ##
    # Returns the number of values stored in one pixel.
    # \return The number of values in a pixel. 
    def get_channels(self):
        return self.mat.getChannels()

    ##
    # Returns the format of the matrix.
    # \return The format of the current \ref Mat .
    def get_data_type(self):
        return MAT_TYPE(<int>self.mat.getDataType())

    # Returns the format of the matrix.
    # \return The format of the current \ref Mat
    def get_memory_type(self):
        return MEM(<int>self.mat.getMemoryType())

    # Copies the data of the \ref Mat in a Numpy array.
    # \param memory_type : defines which memory should be read.
    # \return A Numpy array containing the \ref Mat data.
    def get_data(self, memory_type=MEM.CPU):
        shape = None
        if self.mat.getChannels() == 1:
            shape = (self.mat.getHeight(), self.mat.getWidth())
        else:
            shape = (self.mat.getHeight(), self.mat.getWidth(), self.mat.getChannels())

        cdef size_t size = 0
        dtype = None
        if self.mat.getDataType() in (c_MAT_TYPE.U8_C1, c_MAT_TYPE.U8_C2, c_MAT_TYPE.U8_C3, c_MAT_TYPE.U8_C4):
            size = self.mat.getHeight()*self.mat.getWidth()*self.mat.getChannels()
            dtype = np.uint8
        elif self.mat.getDataType() in (c_MAT_TYPE.F32_C1, c_MAT_TYPE.F32_C2, c_MAT_TYPE.F32_C3, c_MAT_TYPE.F32_C4):
            size = self.mat.getHeight()*self.mat.getWidth()*self.mat.getChannels()*sizeof(float)
            dtype = np.float32
        else:
            raise RuntimeError("Unknown Mat data_type value: {0}".format(<int>self.mat.getDataType()))

        cdef np.ndarray arr = np.zeros(shape, dtype=dtype)
        if isinstance(memory_type, MEM):
            if self.mat.getDataType() == c_MAT_TYPE.U8_C1:
                memcpy(<void*>arr.data, <void*>getPointerUchar1(self.mat, <c_MEM>(<unsigned int>memory_type.value)), size)
            elif self.mat.getDataType() == c_MAT_TYPE.U8_C2:
                memcpy(<void*>arr.data, <void*>getPointerUchar2(self.mat, <c_MEM>(<unsigned int>memory_type.value)), size)
            elif self.mat.getDataType() == c_MAT_TYPE.U8_C3:
                memcpy(<void*>arr.data, <void*>getPointerUchar3(self.mat, <c_MEM>(<unsigned int>memory_type.value)), size)
            elif self.mat.getDataType() == c_MAT_TYPE.U8_C4:
                memcpy(<void*>arr.data, <void*>getPointerUchar4(self.mat, <c_MEM>(<unsigned int>memory_type.value)), size)
            elif self.mat.getDataType() == c_MAT_TYPE.F32_C1:
                memcpy(<void*>arr.data, <void*>getPointerFloat1(self.mat, <c_MEM>(<unsigned int>memory_type.value)), size)
            elif self.mat.getDataType() == c_MAT_TYPE.F32_C2:
                memcpy(<void*>arr.data, <void*>getPointerFloat2(self.mat, <c_MEM>(<unsigned int>memory_type.value)), size)
            elif self.mat.getDataType() == c_MAT_TYPE.F32_C3:
                memcpy(<void*>arr.data, <void*>getPointerFloat3(self.mat, <c_MEM>(<unsigned int>memory_type.value)), size)
            elif self.mat.getDataType() == c_MAT_TYPE.F32_C4:
                memcpy(<void*>arr.data, <void*>getPointerFloat4(self.mat, <c_MEM>(<unsigned int>memory_type.value)), size)
        else:
            raise TypeError("Argument is not of MEM type.")

        return arr

    ##
    # Returns the memory step in Bytes (the Bytes size of one pixel row).
    # \param memory_type : defines which memory should be read.
    # \return The step in bytes of the specified memory.
    def get_step_bytes(self, memory_type=MEM.CPU):
        if type(memory_type) == MEM:
            return self.mat.getStepBytes(<c_MEM>(<unsigned int>memory_type.value))
        else:
            raise TypeError("Argument is not of MEM type.")

    ##
    # Returns the memory step in number of elements (the number of values in one pixel row).
    # \param memory_type : defines which memory should be read.
    # \return The step in number of elements.
    def get_step(self, memory_type=MEM.CPU):
        if type(memory_type) == MEM:
            return self.mat.getStep(<c_MEM>(<unsigned int>memory_type.value))
        else:
            raise TypeError("Argument is not of MEM type.")

    ##
    # Returns the size in bytes of one pixel.
    # \return The size in bytes of a pixel.
    def get_pixel_bytes(self):
        return self.mat.getPixelBytes()

    ##
    # Returns the size in bytes of a row.
    # \return The size in bytes of a row.
    def get_width_bytes(self):
        return self.mat.getWidthBytes()

    ##
    # Returns the informations about the \ref Mat into a string.
    # \return A string containing the \ref Mat informations.
    def get_infos(self):
        return self.mat.getInfos().get().decode()

    ##
    # Defines whether the \ref Mat is initialized or not.
    # \return True if current \ref Mat has been allocated (by the constructor or therefore).
    def is_init(self):
        return self.mat.isInit()

    ##
    # Returns whether the \ref Mat is the owner of the memory it access.
    #
    # If not, the memory won't be freed if the Mat is destroyed.
    # \return True if the \ref Mat is owning its memory, else false.
    def is_memory_owner(self):
        return self.mat.isMemoryOwner()

    ##
    # Duplicates \ref Mat by copy (deep copy).
    # \param py_mat : the reference to the \ref Mat to copy. This function copies the data array(s), it mark the new \ref Mat as the memory owner.
    def clone(self, Mat py_mat):
        return ERROR_CODE(<int>self.mat.clone(py_mat.mat))

    ##
    # Moves Mat data to another \ref Mat.
    #
    # This function gives the attribute of the current \ref Mat to the specified one. (No copy).
    # \param py_mat : the \ref Mat to move.
    #
    # \note the current \ref Mat is then no more usable since it loses its attributes.
    def move(self, Mat py_mat):
        return ERROR_CODE(<int>self.mat.move(py_mat.mat))

    ##
    # Swaps the content of the provided \ref Mat (only swaps the pointers, no data copy). Static Method.
    #
    # This function swaps the pointers of the given \ref Mat.
    # \param mat1 : the first mat.
    # \param mat2 : the second mat.
    @staticmethod
    def swap(Mat mat1, Mat mat2):
        cdef c_Mat tmp
        tmp = mat1.mat
        mat1.mat = mat2.mat
        mat2.mat = tmp

    ##
    # Gets the pointer of the content of the \ref Mat.
    #
    # \param memory_type : Wether you want the \ref MEM CPU or GPU
    # \return the pointer of the content of the \ref Mat.
    def get_pointer(self, memory_type=MEM.CPU) :
        ptr = <unsigned long long>getPointerUchar1(self.mat, <c_MEM>(<unsigned int>memory_type.value))
        return ptr

    ##
    # The name of the \ref Mat (optional). In \ref verbose mode, it's used to indicate which \ref Mat is printing informations. Default set to "n/a" to avoid empty string if not filled.
    @property
    def name(self):
        if not self.mat.name.empty():
            return self.mat.name.get().decode()
        else:
            return ""

    @name.setter
    def name(self, str name_):
        self.mat.name.set(name_.encode())

    ##
    # Whether the \ref Mat can display informations or not.
    @property
    def verbose(self):
        return self.mat.verbose

    @verbose.setter
    def verbose(self, bool verbose_):
        self.mat.verbose = verbose_

    def __repr__(self):
        return self.get_infos()


##
# Designed to contain rotation data of the positional tracking. It inherits from the generic \ref Matrix3f .
# \ingroup PositionalTracking_group
cdef class Rotation(Matrix3f):
    cdef c_Rotation rotation
    def __cinit__(self):
        self.rotation = c_Rotation()

    ##
    # Deep copy from another \ref Rotation .
    # \param rot : \ref Rotation to be copied.
    def init_rotation(self, Rotation rot):
        self.rotation = c_Rotation(rot.rotation)
        self.mat = rot.mat

    ##
    # Inits the \ref Rotation from a \ref Matrix3f .
    # \param matrix : \ref Matrix3f to be used.
    def init_matrix(self, Matrix3f matrix):
        self.rotation = c_Rotation(matrix.mat)
        self.mat = matrix.mat

    ##
    # Inits the \ref Rotation from a \ref Orientation .
    # \param orient : \ref Orientation to be used.
    def init_orientation(self, Orientation orient):
        self.rotation = c_Rotation(orient.orientation)
        self.mat = c_Matrix3f(self.rotation.r)

    ##
    # Inits the \ref Rotation from an angle and an arbitrary 3D axis.
    # \param angle : The rotation angle in rad.
    # \param axis : the 3D axis (\ref Translation) to rotate around
    def init_angle_translation(self, float angle, Translation axis):
        self.rotation = c_Rotation(angle, axis.translation)
        self.mat = c_Matrix3f(self.rotation.r)

    ##
    # Sets the \ref Rotation from an \ref Orientation .
    # \param py_orientation : the \ref Orientation containing the rotation to set.
    def set_orientation(self, Orientation py_orientation):
        self.rotation.setOrientation(py_orientation.orientation)

    ##
    # Returns the \ref Orientation corresponding to the current \ref Rotation .
    # \return The orientation of the current rotation.
    def get_orientation(self):
        py_orientation = Orientation()
        py_orientation.orientation = self.rotation.getOrientation()
        return py_orientation

    ##
    # Returns the 3x1 rotation vector obtained from 3x3 rotation matrix using Rodrigues formula.
    # \return The rotation vector (numpy array)
    def get_rotation_vector(self):
        cdef np.ndarray arr = np.zeros(3)
        for i in range(3):
            arr[i] = self.rotation.getRotationVector()[i]
        return arr

    ##
    # Sets the \ref Rotation from a rotation vector (using Rodrigues' transformation).
    # \param input0 : First float value
    # \param input1 : Second float value
    # \param input2 : Third float value
    def set_rotation_vector(self, float input0, float input1, float input2):
        self.rotation.setRotationVector(Vector3[float](input0, input1, input2))

    ##
    # Converts the \ref Rotation as Euler angles.
    # \param radian : Defines if the angle in is radian or degree.
    # \return The Euler angles, as a numpy array representing the rotations arround the X, Y and Z axes.
    def get_euler_angles(self, radian=True):
        cdef np.ndarray arr = np.zeros(3)
        if isinstance(radian, bool):
            for i in range(3):
                arr[i] = self.rotation.getEulerAngles(radian)[i]
        else:
            raise TypeError("Argument is not of boolean type.")
        return arr

    ##
    # Sets the \ref Rotation from the Euler angles
    # \param input0 : Roll value
    # \param input1 : Pitch value
    # \param input2 : Yaw value
    # \param radian : Defines if the angle is in radian or degree.
    def set_euler_angles(self, float input0, float input1, float input2, bool radian=True):
        if isinstance(radian, bool):
            self.rotation.setEulerAngles(Vector3[float](input0, input1, input2), radian)
        else:
            raise TypeError("Argument is not of boolean type.")

##
# Designed to contain translation data of the positional tracking.
# \ingroup PositionalTracking_group
#
# \ref Translation is a vector as [tx, ty, tz]. You can access the data with the \ref get method that returns a numpy array.
cdef class Translation:
    cdef c_Translation translation
    def __cinit__(self):
        self.translation = c_Translation()

    ##
    # Deep copy from another \ref Translation
    # \param tr : \ref Translatoin to be copied
    def init_translation(self, Translation tr):
        self.translation = c_Translation(tr.translation)

    ##
    # \param t1 : First float value
    # \param t2 : Second float value
    # \param t3 : Third float value
    def init_vector(self, float t1, float t2, float t3):
        self.translation = c_Translation(t1, t2, t3)

    ##
    # Normalizes the current translation.
    def normalize(self):
        self.translation.normalize()

    ##
    # Gets the normalized version of a given \ref Translation .
    # \param tr : \ref Translation to be used
    # \return Another \ref Translation object, which is equal to tr.normalize.
    def normalize_translation(self, Translation tr):
        py_translation = Translation()
        py_translation.translation = self.translation.normalize(tr.translation)
        return py_translation

    ##
    # Gets the size of the translation vector.
    # \return the vector size
    def size(self):
        return self.translation.size()

    ##
    # Gets the \ref Translation as a numpy array.
    # \return A numpy array of float with the \ref Translation values.
    def get(self):
        cdef np.ndarray arr = np.zeros(self.size())
        for i in range(self.size()):
            arr[i] = <float>self.translation(i)
        return arr

    def __mul__(Translation self, Orientation other):
        tr = Translation()
        tr.translation = self.translation * other.orientation
        return tr

##
# Designed to contain orientation (quaternion) data of the positional tracking.
# \ingroup PositionalTracking_group
#
# \ref Orientation is a vector defined as [ox, oy, oz, ow].
cdef class Orientation:
    cdef c_Orientation orientation
    def __cinit__(self):
        self.orientation = c_Orientation()

    ##
    # Deep copy from another \ref Orientation
    # \param orient : \ref Orientation to be copied.
    def init_orientation(self, Orientation orient):
        self.orientation = c_Orientation(orient.orientation)

    ##
    # Inits \ref Orientation from float values.
    # \param v0 : ox value
    # \param v1 : oy value
    # \param v2 : oz value
    # \param v3 : ow value
    def init_vector(self, float v0, float v1, float v2, float v3):
        self.orientation = c_Orientation(Vector4[float](v0, v1, v2, v3))

    ##
    # Inits \ref Orientation from \ref Rotation .
    #
    # It converts the \ref Rotation representation to the \ref Orientaiton one.
    # \param rotation : \ref Rotation to be converted
    def init_rotation(self, Rotation rotation):
        self.orientation = c_Orientation(rotation.rotation)

    ##
    # Inits \ref Orientation from \ref Translation
    # \param tr1 : First \ref Translation
    # \param tr2 : Second \ref Translation
    def init_translation(self, Translation tr1, Translation tr2):
        self.orientation = c_Orientation(tr1.translation, tr2.translation)

    ##
    # Sets the orientation from a \ref Rotation
    # \param rotation : the \ref Rotation to be used.
    def set_rotation_matrix(self, Rotation py_rotation):
        self.orientation.setRotationMatrix(py_rotation.rotation)

    ##
    # Returns the current orientation as a \ref Rotation .
    # \return The rotation computed from the orientation data.
    def get_rotation_matrix(self):
        py_rotation = Rotation()
        py_rotation.mat = self.orientation.getRotationMatrix()
        return py_rotation

    ##
    # Sets the current \ref Orientation to identity.
    def set_identity(self):
        self.orientation.setIdentity()
        return self

    ##
    # Creates an \ref Orientation initialized to identity.
    # \return An identity class \ref Orientation .
    def identity(self):
        self.orientation.identity()
        return self

    ##
    # Fills the current \ref Orientation with zeros.
    def set_zeros(self):
        self.orientation.setZeros()

    ##
    # Creates an \ref Orientation filled with zeros.
    # \return An \ref Orientation filled with zeros.
    def zeros(self, Orientation orient=Orientation()):
        orient.orientation.zeros()
        return orient

    ##
    # Normalizes the current \ref Orientation .
    def normalize(self):
        self.orientation.normalise()

    ##
    # Creates the normalized version of an existing \ref Orientation .
    # \param orient : the \ref Orientation to be used.
    # \return The normalized version of the \ref Orientation .
    @staticmethod
    def normalize_orientation(Orientation orient):
        orient.orientation.normalise()
        return orient

    ##
    # The size of the orientation vector.
    # \return the size of the orientation vector.
    def size(self):
        return self.orientation.size()

    ##
    # Returns a numpy array of the \ref Orientation .
    # \return A numpy array of the \ref Orientation .
    def get(self):
        cdef np.ndarray arr = np.zeros(self.size())
        for i in range(self.size()):
            arr[i] = <float>self.orientation(i)
        return arr

    def __mul__(Orientation self, Orientation other):
        orient = Orientation()
        orient.orientation = self.orientation * other.orientation
        return orient


##
# Designed to contain translation and rotation data of the positional tracking.
# \ingroup PositionalTracking_group
# It contains the orientation as well. It can be used to create any type of Matrix4x4 or \ref Matrix4f that must be specifically used for handling a rotation and position information (OpenGL, Tracking...). It inherits from the generic \ref Matrix4f .
cdef class Transform(Matrix4f):
    cdef c_Transform transform
    def __cinit__(self):
        self.transform = c_Transform()

    ##
    # Deep copy from another \ref Transform
    # \param motion : \ref Transform to be copied
    def init_transform(self, Transform motion):
        self.transform = c_Transform(motion.transform)
        self.mat = motion.mat

    ##
    # Inits \ref Transform from a \ref Matrix4f
    # \param matrix : \ref Matrix4f to be used
    def init_matrix(self, Matrix4f matrix):
        self.transform = c_Transform(matrix.mat)
        self.mat = matrix.mat

    ##
    # Inits \ref Transform from a \ref Rotation and a \ref Translation .
    # \param rot : \ref Rotation to be used.
    # \param tr : \ref Translation to be used.
    def init_rotation_translation(self, Rotation rot, Translation tr):
        self.transform = c_Transform(rot.rotation, tr.translation)
        self.mat = c_Matrix4f(self.transform.m)

    ##
    # Inits \ref Transform from a \ref Orientation and a \ref Translation .
    # \param orient : \ref Orientation to be used
    # \param tr : \ref Translation to be used
    def init_orientation_translation(self, Orientation orient, Translation tr):
        self.transform = c_Transform(orient.orientation, tr.translation)
        self.mat = c_Matrix4f(self.transform.m)

    ##
    # Sets the rotation of the current \ref Transform from a \ref Rotation .
    # \param py_rotation : the \ref Rotation to be used.
    def set_rotation_matrix(self, Rotation py_rotation):
        self.transform.setRotationMatrix(<c_Rotation>py_rotation.mat)

    ##
    # Returns the \ref Rotation of the current \ref Transform .
    # \return The \ref Rotation of the current \ref Transform .
    def get_rotation_matrix(self):
        py_rotation = Rotation()
        py_rotation.mat = self.transform.getRotationMatrix()
        return py_rotation

    ##
    # Sets the translation of the current \ref Transform from a \ref Translation .
    # \param py_translation : \ref Translation to be used.
    def set_translation(self, Translation py_translation):
        self.transform.setTranslation(py_translation.translation)

    ##
    # Returns the \ref Translation of the current \ref Transform .
    # \return the \ref Translation created from the \ref Transform values .
    # \warning the given \ref Translation contains a copy of the \ref Transform values.
    def get_translation(self):
        py_translation = Translation()
        py_translation.translation = self.transform.getTranslation()
        return py_translation

    ##
    # Sets the orientation of the current \ref Transform from an \ref Orientation .
    # \param py_orientation : \ref Orientation to be used.
    def set_orientation(self, Orientation py_orientation):
        self.transform.setOrientation(py_orientation.orientation)

    ##
    # Returns the \ref Orientation of the current \ref Transform .
    # \return The \ref Orientation created from the \ref Transform values.
    # \warning the given \ref Orientation contains a copy of the \ref Transform values.
    def get_orientation(self):
        py_orientation = Orientation()
        py_orientation.orientation = self.transform.getOrientation()
        return py_orientation

    ##
    # Returns the 3x1 rotation vector obtained from 3x3 rotation matrix using Rodrigues formula.
    # \return The rotation vector (numpy array)
    def get_rotation_vector(self):
        cdef np.ndarray arr = np.zeros(3)
        for i in range(3):
            arr[i] = self.transform.getRotationVector()[i]
        return arr

    ##
    # Sets the Rotation 3x3 of the Transform with a 3x1 rotation vector (using Rodrigues' transformation).
    # \param input0 : First float value
    # \param input1 : Second float value
    # \param input2 : Third float value
    def set_rotation_vector(self, float input0, float input1, float input2):
        self.transform.setRotationVector(Vector3[float](input0, input1, input2))

    ##
    # Converts the \ref Rotation of the \ref Transform as Euler angles.
    # \param radian : Define if the angle in is radian or degree.
    # \return The Euler angles, as float3 representing the rotations around the x, y and z axes.
    def get_euler_angles(self, radian=True):
        cdef np.ndarray arr = np.zeros(3)
        if isinstance(radian, bool):
            for i in range(3):
                arr[i] = self.transform.getEulerAngles(radian)[i]
        else:
            raise TypeError("Argument is not of boolean type.")
        return arr

    ##
    # Sets the \ref Rotation of the \ref Transform from the Euler angles.
    # \param input0 : First float euler value.
    # \param input1 : Second float euler value.
    # \param input2 : Third float euler value.
    # \param radian : Define if the angle in is radian or degree.
    def set_euler_angles(self, float input0, float input1, float input2, radian=True):
        if isinstance(radian, bool):
            self.transform.setEulerAngles(Vector3[float](input0, input1, input2), radian)
        else:
            raise TypeError("Argument is not of boolean type.")


##
# Lists available mesh file formats.
# \ingroup SpatialMapping_group
#
# | Enumerator     |                  |
# |----------------|------------------|
# | PLY | Contains only vertices and faces. |
# | PLY_BIN | Contains only vertices and faces, encoded in binary. |
# | OBJ | Contains vertices, normals, faces and textures informations if possible. |
class MESH_FILE_FORMAT(enum.Enum):
    PLY = <int>c_MESH_FILE_FORMAT.PLY
    PLY_BIN = <int>c_MESH_FILE_FORMAT.PLY_BIN
    OBJ = <int>c_MESH_FILE_FORMAT.OBJ
    LAST = <int>c_MESH_FILE_FORMAT.MESH_FILE_FORMAT_LAST

##
# Lists available mesh texture formats.
# \ingroup SpatialMapping_group
#
# | Enumerator     |                  |
# |----------------|------------------|
# | RGB | The texture has 3 channels. |
# | RGBA | The texture has 4 channels.|
class MESH_TEXTURE_FORMAT(enum.Enum):
    RGB = <int>c_MESH_TEXTURE_FORMAT.RGB
    RGBA = <int>c_MESH_TEXTURE_FORMAT.RGBA
    LAST = <int>c_MESH_TEXTURE_FORMAT.MESH_TEXTURE_FORMAT_LAST

##
# Lists available mesh filtering intensity.
# \ingroup SpatialMapping_group
#
# | Enumerator     |                  |
# |----------------|------------------|
# | LOW | Clean the mesh by closing small holes and removing isolated faces |
# | MEDIUM | Soft decimation and smoothing. |
# | HIGH | Decimate the number of triangles and apply a soft smooth. |
class MESH_FILTER(enum.Enum):
    LOW = <int>c_MESH_FILTER.LOW
    MEDIUM = <int>c_MESH_FILTER.MESH_FILTER_MEDIUM
    HIGH = <int>c_MESH_FILTER.HIGH

##
# List available plane type detected from the orientation
#
# \ingroup SpatialMapping_group
#
# | Enumerator |                  |
# |------------|------------------|
# | HORIZONTAL |                  |
# | VERTICAL | |
# | UNKNOWN | |
class PLANE_TYPE(enum.Enum):
    HORIZONTAL = <int>c_PLANE_TYPE.HORIZONTAL
    VERTICAL = <int>c_PLANE_TYPE.VERTICAL
    UNKNOWN = <int>c_PLANE_TYPE.UNKNOWN
    LAST = <int>c_PLANE_TYPE.PLANE_TYPE_LAST

##
# Defines the behavior of the \ref Mesh.filter() function.
# \ingroup SpatialMapping_group
# The constructor sets all the default parameters.
cdef class MeshFilterParameters:
    cdef c_MeshFilterParameters* meshFilter
    def __cinit__(self):
        self.meshFilter = new c_MeshFilterParameters(c_MESH_FILTER.LOW)

    def __dealloc__(self):
        del self.meshFilter

    ##
    # Set the filtering intensity.
    # \param filter : the desired \ref MESH_FILTER
    def set(self, filter=MESH_FILTER.LOW):
        if isinstance(filter, MESH_FILTER):
            self.meshFilter.set(<c_MESH_FILTER>(<unsigned int>filter.value))
        else:
            raise TypeError("Argument is not of MESH_FILTER type.")

    ##
    # Saves the current bunch of parameters into a file.
    # \param filename : the path to the file in which the parameters will be stored.
    # \return true if the file was successfully saved, otherwise false.
    def save(self, str filename):
        filename_save = filename.encode()
        return self.meshFilter.save(String(<char*> filename_save))

    ##
    # Loads the values of the parameters contained in a file.
    # \param filename : the path to the file from which the parameters will be loaded.
    # \return true if the file was successfully loaded, otherwise false.
    def load(self, str filename):
        filename_load = filename.encode()
        return self.meshFilter.load(String(<char*> filename_load))

##
# Represents a sub fused point cloud, it contains local vertices and colors.
# \ingroup SpatialMapping_group
# Vertices and normals have the same size.
cdef class PointCloudChunk :
    cdef c_PointCloudChunk chunk

    def __cinit__(self):
        self.chunk = c_PointCloudChunk()
    ##
    # Vertices are defined by a colored 3D point {x, y, z, rgba}. A numpy array.
    @property
    def vertices(self):
        cdef np.ndarray arr = np.zeros((self.chunk.vertices.size(), 3), dtype=np.float32)
        for i in range(self.chunk.vertices.size()):
            for j in range(3):
                arr[i,j] = self.chunk.vertices[i].ptr()[j]
        return arr

    ##
    # Normals are defined by three components, {nx, ny, nz}. A numpy array.
    @property
    def normals(self):
        cdef np.ndarray arr = np.zeros((self.chunk.normals.size(), 3), dtype=np.float32)
        for i in range(self.chunk.normals.size()):
            for j in range(3):
                arr[i,j] = self.chunk.normals[i].ptr()[j]
        return arr

    ##
    # Timestamp of the latest update in nanoseconds.
    @property
    def timestamp(self):
        return self.chunk.timestamp

    ##
    # 3D centroid of the chunk. A numpy array.
    @property
    def barycenter(self):
        cdef np.ndarray arr = np.zeros(3, dtype=np.float32)
        for i in range(3):
            arr[i] = self.chunk.barycenter[i]
        return arr

    ##
    # True if the chunk has been updated by an inner process.
    @property
    def has_been_updated(self):
        return self.chunk.has_been_updated

    ##
    # Clears all chunk data.
    def clear(self):
        self.chunk.clear()

##
# Represents a sub-mesh, it contains local vertices and triangles.
# \ingroup SpatialMapping_group
#
# Vertices and normals have the same size and are linked by id stored in triangles.
# \note uv contains data only if your mesh have textures (by loading it or after calling apply_texture)
cdef class Chunk:
    cdef c_Chunk chunk
    def __cinit__(self):
        self.chunk = c_Chunk()

    ##
    # Vertices are defined by a 3D point (numpy array).
    @property
    def vertices(self):
        cdef np.ndarray arr = np.zeros((self.chunk.vertices.size(), 3), dtype=np.float32)
        for i in range(self.chunk.vertices.size()):
            for j in range(3):
                arr[i,j] = self.chunk.vertices[i].ptr()[j]
        return arr

    ##
    # Triangles (or faces) contains the index of its three vertices. It corresponds to the 3 vertices of the triangle (numpy array).
    @property
    def triangles(self):
        cdef np.ndarray arr = np.zeros((self.chunk.triangles.size(), 3))
        for i in range(self.chunk.triangles.size()):
            for j in range(3):
                arr[i,j] = self.chunk.triangles[i].ptr()[j]+1
        return arr

    ##
    # Normals are defined by three components (numpy array). Normals are defined for each vertices.
    @property
    def normals(self):
        cdef np.ndarray arr = np.zeros((self.chunk.normals.size(), 3), dtype=np.float32)
        for i in range(self.chunk.normals.size()):
            for j in range(3):
                arr[i,j] = self.chunk.normals[i].ptr()[j]
        return arr

    ##
    # UVs defines the 2D projection of each vertices onto the texture.
    # Values are normalized [0;1], starting from the bottom left corner of the texture (as requested by opengl).
    # In order to display a textured mesh you need to bind the :class:`~pyzed.sl.Texture` and then draw each triangles by picking its uv values.
    # \note Contains data only if your mesh have textures (by loading it or calling apply_texture).
    @property
    def uv(self):
        cdef np.ndarray arr = np.zeros((self.chunk.uv.size(), 2), dtype=np.float32)
        for i in range(self.chunk.uv.size()):
            for j in range(2):
                arr[i,j] = self.chunk.uv[i].ptr()[j]
        return arr

    ##
    # Timestamp of the latest update.
    @property
    def timestamp(self):
        return self.chunk.timestamp

    ##
    # 3D centroid of the chunk.
    @property
    def barycenter(self):
        cdef np.ndarray arr = np.zeros(3, dtype=np.float32)
        for i in range(3):
            arr[i] = self.chunk.barycenter[i]
        return arr

    ##
    # True if the chunk has been updated by an inner process.
    @property
    def has_been_updated(self):
        return self.chunk.has_been_updated

    ##
    # Clears all chunk data.
    def clear(self):
        self.chunk.clear()

##
# A fused point cloud contains both geometric and color data of the scene captured by spatial mapping.
# \ingroup SpatialMapping_group
#
# By default the fused point cloud is defined as a set of point cloud chunks, this way we update only the required data, avoiding a time consuming remapping process every time a small part of the fused point cloud is changed.
cdef class FusedPointCloud :
    cdef c_FusedPointCloud* fpc
    def __cinit__(self):
        self.fpc = new c_FusedPointCloud()

    def __dealloc__(self):
        del self.fpc

    ##
    # contains the list of chunks
    @property
    def chunks(self):
        list = []
        for i in range(self.mesh.chunks.size()):
            py_chunk = PointCloudChunk()
            py_chunk.chunk = self.fpc.chunks[i]
            list.append(py_chunk)
        return list

    ##
    # gets a chunk from the list
    def __getitem__(self, x):
        return self.chunks[x]

    ##
    # Vertices are defined by colored 3D points {x, y, z, rgba}. A numpy array.
    @property
    def vertices(self):
        cdef np.ndarray arr = np.zeros((self.fpc.vertices.size(), 3), dtype=np.float32)
        for i in range(self.fpc.vertices.size()):
            for j in range(3):
                arr[i,j] = self.fpc.vertices[i].ptr()[j]
        return arr

    ##
    # Normals are defined by three components, {nx, ny, nz}. Normals are defined for each vertices. A numpy array.
    @property
    def normals(self):
        cdef np.ndarray arr = np.zeros((self.fpc.normals.size(), 3), dtype=np.float32)
        for i in range(self.fpc.normals.size()):
            for j in range(3):
                arr[i,j] = self.fpc.normals[i].ptr()[j]
        return arr

    ##
    # Saves the current fused point cloud into a file.
    # \param filename : the path and filename of the mesh.
    # \param type : defines the file type (extension). default : MESH_FILE_OBJ.
    # \param IDs : (by default empty) Specify a set of chunks to be saved, if none provided all chunks are saved. default : (empty).
    # \return True if the file was successfully saved, false otherwise.
    #
    #  \note Only \ref MESH_FILE_OBJ support textures data.
    # \note This function operates on the fused point cloud not on the chunks. This way you can save different parts of your fused point cloud (update with \ref update_from_chunk_list).
    def save(self, str filename, typeMesh=MESH_FILE_FORMAT.OBJ, id=[]):
        if isinstance(typeMesh, MESH_FILE_FORMAT):
            return self.fpc.save(String(filename.encode()), <c_MESH_FILE_FORMAT>(<unsigned int>typeMesh.value), id)
        else:
            raise TypeError("Argument is not of MESH_FILE_FORMAT type.")

    ##
    # Loads the fused point cloud from a file.
    # \param filename : the path and filename of the fused point cloud (do not forget the extension).
    # \param update_chunk_only : if set to false the fused point cloud data (vertices/normals) are updated otherwise only the chunk's data are updated. default : false.
    # \return True if the loading was successful, false otherwise.
    # \note Updating the fused point cloud is time consuming, consider using only chunks for better performances.
    def load(self, str filename, update_mesh=True):
        if isinstance(update_mesh, bool):
            return self.fpc.load(String(filename.encode()), update_mesh)
        else:
            raise TypeError("Argument is not of boolean type.")

    ##
    # Clears all the data.
    def clear(self):
        self.fpc.clear()

    ##
    # Updates \ref vertices / \ref normals / \ref colors from chunks' data pointed by the given chunk list.
    # \param IDs : the index of chunks which will be concatenated. default : (empty).
    # \note If the given chunkList is empty, all chunks will be used.
    def update_from_chunklist(self, id=[]):
        self.fpc.updateFromChunkList(id)

    ##
    # Computes the total number of triangles stored in all chunks.
    # \return The number of points stored in all chunks.
    def get_number_of_points(self):
        return self.fpc.getNumberOfPoints()


##
# A mesh contains the geometric (and optionally texture) data of the scene captured by spatial mapping.
# \ingroup SpatialMapping_group
# By default the mesh is defined as a set of chunks, this way we update only the data that has to be updated avoiding a time consuming remapping process every time a small part of the Mesh is updated.
cdef class Mesh:
    cdef c_Mesh* mesh
    def __cinit__(self):
        self.mesh = new c_Mesh()

    def __dealloc__(self):
        del self.mesh

    ##
    # contains the list of chunks
    @property
    def chunks(self):
        list = []
        for i in range(self.mesh.chunks.size()):
            py_chunk = Chunk()
            py_chunk.chunk = self.mesh.chunks[i]
            list.append(py_chunk)
        return list

    ##
    # gets a chunk from the list
    def __getitem__(self, x):
        return self.chunks[x]

    ##
    # Filters the mesh.
    # The resulting mesh in smoothed, small holes are filled and small blobs of non connected triangles are deleted.
    # \param params : defines the filtering parameters, for more info checkout the \ref MeshFilterParameters documentation. default : preset.
    # \param update_chunk_only : if set to false the mesh data (vertices/normals/triangles) are updated otherwise only the chunk's data are updated. default : false.
    # \return True if the filtering was successful, false otherwise.
    #
    # \note The filtering is a costly operation, its not recommended to call it every time you retrieve a mesh but at the end of your spatial mapping process.
    def filter(self, MeshFilterParameters params=MeshFilterParameters(), update_mesh=True):
        if isinstance(update_mesh, bool):
            return self.mesh.filter(deref(params.meshFilter), update_mesh)
        else:
            raise TypeError("Argument is not of boolean type.")

    ##
    # Applies texture to the mesh.
    # By using this function you will get access to \ref uv, and \ref texture.
    # The number of triangles in the mesh may slightly differ before and after calling this functions due to missing texture information.
    # There is only one texture for the mesh, the uv of each chunks are expressed for it in its entirety.
    # Vectors of vertices/normals and uv have now the same size.
    # \param texture_format : define the number of channels desired for the computed texture. default : \ref MESH_TEXTURE_FORMAT.RGB.
    #
    # \note This function can be called as long as you do not start a new spatial mapping process, due to shared memory.
    # \note This function can require a lot of computation time depending on the number of triangles in the mesh. Its recommended to call it once a the end of your spatial mapping process.
    # 
    # \warning The save_texture parameter in \ref SpatialMappingParameters must be set as true when enabling the spatial mapping to be able to apply the textures.
    def apply_texture(self, texture_format=MESH_TEXTURE_FORMAT.RGB):
        if isinstance(texture_format, MESH_TEXTURE_FORMAT):
            return self.mesh.applyTexture(<c_MESH_TEXTURE_FORMAT>(<unsigned int>texture_format.value))
        else:
            raise TypeError("Argument is not of MESH_TEXTURE_FORMAT type.")

    ##
    # Saves the current Mesh into a file.
    # \param filename : the path and filename of the mesh.
    # \param type : defines the file type (extension). default : \ref MESH_FILE_FORMAT.OBJ.
    # \param IDs : (by default empty) Specify a set of chunks to be saved, if none provided all chunks are saved. default : (empty)
    # \return True if the file was successfully saved, false otherwise.
    # 
    # \note Only \ref MESH_FILE_FORMAT.OBJ supports textures data.
    # \note This function operates on the Mesh not on the chunks. This way you can save different parts of your Mesh (update your Mesh with \ref update_mesh_from_chunk_list).
    def save(self, str filename, typeMesh=MESH_FILE_FORMAT.OBJ, id=[]):
        if isinstance(typeMesh, MESH_FILE_FORMAT):
            return self.mesh.save(String(filename.encode()), <c_MESH_FILE_FORMAT>(<unsigned int>typeMesh.value), id)
        else:
            raise TypeError("Argument is not of MESH_FILE_FORMAT type.")

    ##
    # Loads the mesh from a file.
    # \param filename : the path and filename of the mesh (do not forget the extension).
    # \param update_chunk_only : if set to false the mesh data (vertices/normals/triangles) are updated otherwise only the chunk's data are updated. default : false.
    # \return True if the loading was successful, false otherwise.
    #
    # \note Updating the Mesh is time consuming, consider using only Chunks for better performances.
    def load(self, str filename, update_mesh=True):
        if isinstance(update_mesh, bool):
            return self.mesh.load(String(filename.encode()), update_mesh)
        else:
            raise TypeError("Argument is not of boolean type.")

    ##
    # Clears all the data.
    def clear(self):
        self.mesh.clear()

    ##
    # Vertices are defined by a 3D point (numpy array)
    @property
    def vertices(self):
        cdef np.ndarray arr = np.zeros((self.mesh.vertices.size(), 3), dtype=np.float32)
        for i in range(self.mesh.vertices.size()):
            for j in range(3):
                arr[i,j] = self.mesh.vertices[i].ptr()[j]
        return arr

    ##
    # Triangles (or faces) contains the index of its three vertices. It corresponds to the 3 vertices of the triangle (numpy array).
    @property
    def triangles(self):
        cdef np.ndarray arr = np.zeros((self.mesh.triangles.size(), 3))
        for i in range(self.mesh.triangles.size()):
            for j in range(3):
                arr[i,j] = self.mesh.triangles[i].ptr()[j]+1
        return arr

    ##
    # Normals are defined by three components, {nx, ny, nz}. Normals are defined for each vertices. (numpy array)
    @property
    def normals(self):
        cdef np.ndarray arr = np.zeros((self.mesh.normals.size(), 3), dtype=np.float32)
        for i in range(self.mesh.normals.size()):
            for j in range(3):
                arr[i,j] = self.mesh.normals[i].ptr()[j]
        return arr

    ##
    # UVs defines the 2D projection of each vertices onto the texture . (numpy array)
    # Values are normalized [0;1], starting from the bottom left corner of the texture (as requested by opengl).
    # In order to display a textured mesh you need to bind the :class:`~pyzed.sl.Texture` and then draw each triangles by picking its uv values.
    #
    # \note Contains data only if your mesh have textures (by loading it or calling \ref apply_texture())
    @property
    def uv(self):
        cdef np.ndarray arr = np.zeros((self.mesh.uv.size(), 2), dtype=np.float32)
        for i in range(self.mesh.uv.size()):
            for j in range(2):
                arr[i,j] = self.mesh.uv[i].ptr()[j]
        return arr

    ##
    # Texture of the \ref Mesh
    # \return a \ref Mat containing the texture of the \ref Mesh
    # \note Contains data only if your mesh have textures (by loading it or calling \ref apply_texture).
    @property
    def texture(self):
        py_texture = Mat()
        py_texture.mat = self.mesh.texture
        return py_texture

    ##
    # Computes the total number of triangles stored in all chunks.
    # \return The number of triangles stored in all chunks.
    def get_number_of_triangles(self):
        return self.mesh.getNumberOfTriangles()

    ##
    # Merges currents chunks.
    # This can be used to merge chunks into bigger sets to improve rendering process.
    # \param faces_per_chunk : define the new number of faces per chunk (useful for Unity that doesn't handle chunks over 65K vertices).
    # 
    # \note You should not use this function during spatial mapping process because mesh updates will revert this changes.
    def merge_chunks(self, faces_per_chunk):
        self.mesh.mergeChunks(faces_per_chunk)

    ##
    # Estimates the gravity vector.
    # This function looks for a dominant plane in the whole mesh considering that it is the floor (or a horizontal plane). This can be used to find the gravity and then create realistic physical interactions.
    # \return The gravity vector. (numpy array)
    def get_gravity_estimate(self):
        gravity = self.mesh.getGravityEstimate()
        cdef np.ndarray arr = np.zeros(3)
        for i in range(3):
            arr[i] = gravity[i]
        return arr

    ##
    # Computes the list of visible chunk from a specific point of view.
    # \param camera_pose : the point of view, given in world reference.
    # \return The list of visible chunks.
    def get_visible_list(self, Transform camera_pose):
        return self.mesh.getVisibleList(camera_pose.transform)

    ##
    # Computes the list of chunks which are close to a specific point of view.
    # \param camera_pose, : the point of view, given in world reference.
    # \param radius : the radius in defined \ref UNIT
    # \return The list of chunks close to the given point.
    def get_surrounding_list(self, Transform camera_pose, float radius):
        return self.mesh.getSurroundingList(camera_pose.transform, radius)

    ##
    # Updates \ref vertices / \ref normals / \ref triangles \ref uv from chunks' data pointed by given chunkList.
    #
    # \note If the given chunkList is empty, all chunks will be used to update the current \ref Mesh
    def update_mesh_from_chunklist(self, id=[]):
        self.mesh.updateMeshFromChunkList(id)

##
# A plane defined by a point and a normal, or a plane equation. Other elements can be extracted such as the mesh, the 3D bounds...
# \ingroup SpatialMapping_group
# \note The plane measurement are expressed in REFERENCE_FRAME defined by the \ref RuntimeParameters \ref RuntimeParameters.measure_3D_reference_frame .
cdef class Plane:
    cdef c_Plane plane
    def __cinit__(self):
        self.plane = c_Plane()

    ##
    # The plane type define the plane orientation : vertical or horizontal.
    # \warning It is deduced from the gravity vector and is therefore only available with the ZED-M. The ZED will give UNKNOWN for every planes.
    @property
    def type(self):
        return PLANE_TYPE(<int>self.plane.type)

    @type.setter
    def type(self, type_):
        if isinstance(type_, PLANE_TYPE) :
            self.plane.type = <c_PLANE_TYPE>(<unsigned int>type_.value)
        else :
            raise TypeError("Argument is not of PLANE_TYPE type")

    ##
    # Get the plane normal vector.
    # \return \ref Plane normal vector, with normalized components (numpy array)
    def get_normal(self):
        normal = self.plane.getNormal()
        cdef np.ndarray arr = np.zeros(3)
        for i in range(3):
            arr[i] = normal[i]
        return arr

    ##
    # Get the plane center point.
    # \return \ref Plane center point (numpy array)
    def get_center(self):
        center = self.plane.getCenter()
        cdef np.ndarray arr = np.zeros(3)
        for i in range(3):
            arr[i] = center[i]
        return arr

    ##
    # Get the plane pose relative to the global reference frame.
    # \param A \ref Transform or it creates one by default.
    # \return A transformation matrix (rotation and translation) which give the plane pose. Can be used to transform the global reference frame center (0,0,0) to the plane center.
    def get_pose(self, Transform py_pose = Transform()):
        py_pose.transform = self.plane.getPose()
        return py_pose

    ##
    # Gets the width and height of the bounding rectangle around the plane contours.
    # \return Width and height of the bounding plane contours (numpy array)
    # \warning This value is expressed in the plane reference frame.
    def get_extents(self):
        extents = self.plane.getExtents()
        cdef np.ndarray arr = np.zeros(2)
        for i in range(2):
            arr[i] = extents[i]
        return arr

    ##
    # Gets the plane equation.
    # \return \ref Plane equation, in the form : ax+by+cz=d, the returned values are (a,b,c,d) (numpy array)
    def get_plane_equation(self):
        plane_eq = self.plane.getPlaneEquation()
        cdef np.ndarray arr = np.zeros(4)
        for i in range(4):
            arr[i] = plane_eq[i]
        return arr

    ##
    # Get the polygon bounds of the plane.
    # \return Vector of 3D points forming a polygon bounds corresponding to the current visible limits of the plane (numpy array)
    def get_bounds(self):
        cdef np.ndarray arr = np.zeros((self.plane.getBounds().size(), 3))
        for i in range(self.plane.getBounds().size()):
            for j in range(3):
                arr[i,j] = self.plane.getBounds()[i].ptr()[j]
        return arr

    ##
    # Computes and returns the mesh of the bounds polygon.
    # \return A mesh representing the plane delimited by the visible bounds
    def extract_mesh(self):
        ext_mesh = self.plane.extractMesh()
        pymesh = Mesh()
        pymesh.mesh[0] = ext_mesh
        return pymesh

    ##
    # Get the distance between the input point and the projected point alongside the normal vector onto the plane. This corresponds to the closest point on the plane.
    # \param The point to project into the plane
    def get_closest_distance(self, point=[0,0,0]):
        cdef Vector3[float] vec = Vector3[float](point[0], point[1], point[2])
        return self.plane.getClosestDistance(vec)

##
# Lists the spatial mapping resolution presets.
# \ingroup SpatialMapping_group
#
# | Enumerator     |                  |
# |----------------|------------------|
# | HIGH | Create a detail geometry, requires lots of memory. |
# | MEDIUM | Smalls variations in the geometry will disappear, useful for big object |
# | LOW | Keeps only huge variations of the geometry , useful outdoor. |
class MAPPING_RESOLUTION(enum.Enum):
    HIGH = <int>c_MAPPING_RESOLUTION.MAPPING_RESOLUTION_HIGH
    MEDIUM  = <int>c_MAPPING_RESOLUTION.MAPPING_RESOLUTION_MEDIUM
    LOW = <int>c_MAPPING_RESOLUTION.MAPPING_RESOLUTION_LOW

##
# Lists the spatial mapping depth range presets.
# \ingroup SpatialMapping_group
#
# | Enumerator     |                  |
# |----------------|------------------|
# | SHORT | Only depth close to the camera will be used during spatial mapping. |
# | MEDIUM | Medium depth range.  |
# | LONG | Takes into account objects that are far, useful outdoor. |
# | AUTO | Depth range will be computed based on current \ref Camera states and parameters. |
class MAPPING_RANGE(enum.Enum):
    SHORT = <int>c_MAPPING_RANGE.SHORT
    MEDIUM = <int>c_MAPPING_RANGE.MAPPING_RANGE_MEDIUM
    LONG = <int>c_MAPPING_RANGE.LONG
    AUTO = <int>c_MAPPING_RANGE.AUTO

##
# Lists the types of spatial maps that can be created.
# \ingroup SpatialMapping_group
#
# | Enumerator     |                  |
# |----------------|------------------|
# | MESH | Represent a surface with faces, 3D points are linked by edges, no color information. |
# | FUSED_POINT_CLOUD | Geometry is represented by a set of 3D colored points. |
class SPATIAL_MAP_TYPE(enum.Enum):
    MESH = <int>c_SPATIAL_MAP_TYPE.MESH
    FUSED_POINT_CLOUD = <int>c_SPATIAL_MAP_TYPE.FUSED_POINT_CLOUD

##
# Defines the input type used in the ZED SDK. Can be used to select a specific camera with ID or serial number, or a svo file.
# \ingroup Video_group
cdef class InputType:
    cdef c_InputType input
    def __cinit__(self, input_type=0):
        if input_type == 0 :
            self.input = c_InputType()
        elif isinstance(input_type, InputType) :
            input_t = <InputType> input_type
            self.input = c_InputType(input_t.input)
        else :
            raise TypeError("Argument is not of right type.")

    ##
    # Set the input as the camera with specified id
    def set_from_camera_id(self, id):
        self.input.setFromCameraID(id)

    ##
    # Set the input as the camera with specified serial number
    def set_from_serial_number(self, serial_number):
        self.input.setFromSerialNumber(serial_number)

    ##
    # Set the input as the svo specified with the filename
    def set_from_svo_file(self, str svo_input_filename):
        filename = svo_input_filename.encode()
        self.input.setFromSVOFile(String(<char*> filename))

    ##
    # Set the input tostream with the specified ip and port
    def set_from_stream(self, str sender_ip, port=30000):
        sender_ip_ = sender_ip.encode()
        self.input.setFromStream(String(<char*>sender_ip_), port)
 

##
# Holds the options used to initialize the \ref Camera object.
# \ingroup Video_group
# Once passed to the \ref Camera.open() functoin, these settings will be set for the entire execution life time of the \ref Camera.
# You can get further information in the detailed description bellow.
#
# This structure allows you to select multiple parameters for the \ref Camera such as the selected camera, its resolution, depth mode, coordinate system, and unit, of measurement.
# Once filled with the desired options, it should be passed to the \ref Camera.open() function.
# \code
#
#        import pyzed.sl as sl
#
#        def main() :
#            zed = sl.Camera() # Create a ZED camera object
#            init_params = sl.InitParameters() # Set initial parameters
#            init_params.sdk_verbose = False  # Disable verbose mode
#            init_params.camera_resolution = sl.RESOLUTION.HD1080 # Use HD1080 video mode
#            init_params.camera_fps = 30 # Set fps at 30
#            # Other parameters are left to their default values
#
#            # Open the camera
#            err = zed.open(init_params)
#            if err != sl.ERROR_CODE.SUCCESS :
#                exit(-1)
#
#            # Close the camera
#            zed.close()
#            return 0
#
#        if __name__ == "__main__" :
#            main()
#
# \endcode
#
# With its default values, it opens the ZED camera in live mode at \ref RESOLUTION.HD720 and sets the depth mode to \ref DEPTH_MODE.PERFORMANCE
# You can customize it to fit your application.
# The parameters can also be saved and reloaded using its \ref save() and \ref load() functions.
cdef class InitParameters:
    cdef c_InitParameters* init
    ##
    # Constructor.
    # \param camera_resolution : the chosen \ref amera_resolution
    # \param camera_fps : the chosen \ref camera_fps
    # \param svo_real_time_mode : activates \ref svo_real_time_mode
    # \param depth_mode : the chosen \ref depth_mode
    # \param coordinate_units : the chosen \ref coordinate_units
    # \param coordinate_system : the chosen \ref coordinate_system
    # \param sdk_verbose : activates \ref sdk_verbose
    # \param sdk_gpu_id : the chosen \ref sdk_gpu_id
    # \param depth_minimum_distance : the chosen \ref depth_minimum_distance
    # \param depth_maximum_distance : the chosen \ref depth_maximum_distance
    # \param camera_disable_self_calib : activates \ref camera_disable_self_calib
    # \param camera_image_flip : activates \ref camera_image_flip
    # \param enable_right_side_measure : activates \ref enable_right_side_measure
    # \param sdk_verbose_log_file : the chosen \ref sdk_verbose_log_file
    # \param depth_stabilization : activates \ref depth_stabilization
    # \param input_t : the chosen \ref input_t (\ref InputType )
    # \param optional_settings_path : the chosen \ref optional_settings_path
    # \param sensors_required : activates \ref sensors_required
    #
    # \code
    # params = sl.InitParameters(camera_resolution=RESOLUTION.HD720, camera_fps=30, depth_mode=DEPTH_MODE.PERFORMANCE)
    # \endcode
    def __cinit__(self, camera_resolution=RESOLUTION.HD720, camera_fps=0,
                  svo_real_time_mode=False,
                  depth_mode=DEPTH_MODE.PERFORMANCE,
                  coordinate_units=UNIT.MILLIMETER,
                  coordinate_system=COORDINATE_SYSTEM.IMAGE,
                  sdk_verbose=False, sdk_gpu_id=-1, depth_minimum_distance=-1.0, depth_maximum_distance=-1.0, camera_disable_self_calib=False,
                  camera_image_flip=False, enable_right_side_measure=False,
                  sdk_verbose_log_file="", depth_stabilization=1, InputType input_t=InputType(),
                  optional_settings_path="",sensors_required=False,
                  enable_image_enhancement=True):
        if (isinstance(camera_resolution, RESOLUTION) and isinstance(camera_fps, int) and
            isinstance(svo_real_time_mode, bool) and isinstance(depth_mode, DEPTH_MODE) and
            isinstance(coordinate_units, UNIT) and
            isinstance(coordinate_system, COORDINATE_SYSTEM) and isinstance(sdk_verbose, bool) and
            isinstance(sdk_gpu_id, int) and isinstance(depth_minimum_distance, float) and
            isinstance(depth_maximum_distance, float) and
            isinstance(camera_disable_self_calib, bool) and isinstance(camera_image_flip, bool) and
            isinstance(enable_right_side_measure, bool) and
            isinstance(sdk_verbose_log_file, str) and isinstance(depth_stabilization, int) and
            isinstance(input_t, InputType) and isinstance(optional_settings_path, str)) :

            filelog = sdk_verbose_log_file.encode()
            fileoption = optional_settings_path.encode()
            self.init = new c_InitParameters(<c_RESOLUTION>(<unsigned int>camera_resolution.value), camera_fps,
                                            svo_real_time_mode, <c_DEPTH_MODE>(<unsigned int>depth_mode.value),
                                            <c_UNIT>(<unsigned int>coordinate_units.value), <c_COORDINATE_SYSTEM>(<unsigned int>coordinate_system.value), sdk_verbose, sdk_gpu_id,
                                            <float>(depth_minimum_distance), <float>(depth_maximum_distance), camera_disable_self_calib, camera_image_flip,
                                            enable_right_side_measure,
                                            String(<char*> filelog), depth_stabilization,
                                            <CUcontext> 0, input_t.input, String(<char*> fileoption), sensors_required, enable_image_enhancement)
        else:
            raise TypeError("Argument is not of right type.")

    def __dealloc__(self):
        del self.init

    ##
    # This function saves the current set of parameters into a file to be reloaded with the \ref load() function.
    # \param filename : the path to the file in which the parameters will be stored
    # \return True if file was successfully saved, otherwise false.
    # 
    # \code
    #
    # init_params = sl.InitParameters() # Set initial parameters
    # init_params.sdk_verbose = True # Enable verbose mode
    # init_params.set_from_svo_file("/path/to/file.svo") # Selects the and SVO file to be read
    # init_params.save("initParameters.conf") # Export the parameters into a file
    #
    # \endcode
    def save(self, str filename):
        filename_save = filename.encode()
        return self.init.save(String(<char*> filename_save))

    ##
    # This function set the other parameters from the values contained in a previously saved file.
    # \param filename : the path to the file from which the parameters will be loaded.
    # \return True if the file was successfully loaded, otherwise false.
    #
    # \code
    # init_params = sl.InitParameters() # Set initial parameters
    # init_params.load("initParameters.conf") # Load the init_params from a previously exported file
    # \endcode
    def load(self, str filename):
        filename_load = filename.encode()
        return self.init.load(String(<char*> filename_load))

    ##
    # Define the chosen camera resolution. Small resolutions offer higher framerate and lower computation time.
    # In most situations, the \ref RESOLUTION.HD720 at 60 fps is the best balance between image quality and framerate.
    # Available resolutions are listed here: \ref RESOLUTION
    @property
    def camera_resolution(self):
        return RESOLUTION(<int>self.init.camera_resolution)

    @camera_resolution.setter
    def camera_resolution(self, value):
        if isinstance(value, RESOLUTION):
            self.init.camera_resolution = <c_RESOLUTION>(<unsigned int>value.value)
        else:
            raise TypeError("Argument must be of RESOLUTION type.")

    ##
    # Requested camera frame rate. If set to 0, the highest FPS of the specified :data:`~pyzed.sl.InitParameters.camera_resolution` will be used.
    # See \ref RESOLUTION for a list of supported framerates.
    # default 0
    # \note If the requested camera_fps is unsuported, the closest available FPS will be used.
    @property
    def camera_fps(self):
        return self.init.camera_fps

    @camera_fps.setter
    def camera_fps(self, int value):
        self.init.camera_fps = value

    ##
    # Force the motion sensors opening of the ZED 2 / ZED-M to open the camera.
    # default : false
    # If set to false, the SDK will try to <b>open and use</b> the IMU (second USB device on USB2.0) and will open the camera successfully even if the sensors failed to open.
    # This can be used for example when using a USB3.0 only extension cable (some fiber extension for example).
    # This parameter only impacts the LIVE mode.
    # If set to true, the camera will fail to open if the sensors cannot be opened. This parameter should use when the IMU data must be available, such as Object Detection module or when the gravity is needed.
    @property
    def sensors_required(self):
        return self.init.sensors_required

    @sensors_required.setter
    def sensors_required(self, bool value):
        self.init.sensors_required = value

    # Enable or Disable the Enhanced Contrast Technology, to improve image quality.
    # default : true.
    # If set to true, iamge enhancement will be activated in camera ISP. Otherwise, the image will not be enhanced by the IPS.
    # This only works for firmware version starting from 1523 and up.
    @property
    def enable_image_enhancement(self):
        return self.init.enable_image_enhancement

    @enable_image_enhancement.setter
    def enable_image_enhancement(self, bool value):
        self.init.enable_image_enhancement = value

    ##
    # When playing back an SVO file, each call to \ref Camera.grab() will extract a new frame and use it.
    # However, this ignores the real capture rate of the images saved in the SVO file.
    # Enabling this parameter will bring the SDK closer to a real simulation when playing back a file by using the images' timestamps. However, calls to \ref Camera.grab() will return an error when trying to play to fast, and frames will be dropped when playing too slowly.
    @property
    def svo_real_time_mode(self):
        return self.init.svo_real_time_mode

    @svo_real_time_mode.setter
    def svo_real_time_mode(self, bool value):
        self.init.svo_real_time_mode = value

    ##
    # The SDK offers several \ref DEPTH_MODE options offering various level of performance and accuracy.
    # This parameter allows you to set the \ref DEPTH_MODE that best matches your needs.
    # default \ref DEPTH_MODE.PERFORMANCE
    @property
    def depth_mode(self):
        return DEPTH_MODE(<int>self.init.depth_mode)

    @depth_mode.setter
    def depth_mode(self, value):
        if isinstance(value, DEPTH_MODE):
            self.init.depth_mode = <c_DEPTH_MODE>(<unsigned int>value.value)
        else:
            raise TypeError("Argument must be of DEPTH_MODE type.")

    ##
    # This parameter allows you to select the unit to be used for all metric values of the SDK. (depth, point cloud, tracking, mesh, and others).
    # default : \ref UNIT.MILLIMETER
    @property
    def coordinate_units(self):
        return UNIT(<int>self.init.coordinate_units)

    @coordinate_units.setter
    def coordinate_units(self, value):
        if isinstance(value, UNIT):
            self.init.coordinate_units = <c_UNIT>(<unsigned int>value.value)
        else:
            raise TypeError("Argument must be of UNIT type.")

    ##
    # Positional tracking, point clouds and many other features require a given \ref COORDINATE_SYSTEM to be used as reference. This parameter allows you to select the \ref COORDINATE_SYSTEM use by the \ref Camera to return its measures.
    # default : \ref COORDINATE_SYSTEM.IMAGE
    @property
    def coordinate_system(self):
        return COORDINATE_SYSTEM(<int>self.init.coordinate_system)

    @coordinate_system.setter
    def coordinate_system(self, value):
        if isinstance(value, COORDINATE_SYSTEM):
            self.init.coordinate_system = <c_COORDINATE_SYSTEM>(<unsigned int>value.value)
        else:
            raise TypeError("Argument must be of COORDINATE_SYSTEM type.")

    ##
    # This parameters allows you to enable the verbosity of the SDK to get a variety of runtime information in the console. When developing an application, enabling verbose mode can help you understand the current SDK behavior.
    # However, this might not be desirable in a shipped version.
    # default : false
    @property
    def sdk_verbose(self):
        return self.init.sdk_verbose

    @sdk_verbose.setter
    def sdk_verbose(self, bool value):
        self.init.sdk_verbose = value

    ##
    # By default the SDK will use the most powerful NVIDIA graphics card found. However, when running several applications, or using several cameras at the same time, splitting the load over available GPUs can be useful. This parameter allows you to select the GPU used by the \ref Camera using an ID from 0 to n-1 GPUs in your PC.
    # default : -1
    #
    # \note A non-positive value will search for all CUDA capable devices and select the most powerful.
    @property
    def sdk_gpu_id(self):
        return self.init.sdk_gpu_id

    @sdk_gpu_id.setter
    def sdk_gpu_id(self, int value):
        self.init.sdk_gpu_id = value

    ##
    # This parameter allows you to specify the minimum depth value (from the camera) that will be computed, measured in the \ref UNIT you define.
    # In stereovision (the depth technology used by the camera), looking for closer depth values can have a slight impact on performance. However, this difference is almost invisible on modern GPUs.
    # In cases of limited computation power, increasing this value can provide better performance.
    # default : (-1) corresponding to 700 mm for a ZED and 200 mm for ZED Mini.
    # \note With a ZED camera you can decrease this value to 300 mm whereas you can set it to 100 mm using a ZED Mini. In any case this value cannot be greater than 3 meters.
    @property
    def depth_minimum_distance(self):
        return  self.init.depth_minimum_distance

    @depth_minimum_distance.setter
    def depth_minimum_distance(self, float value):
        self.init.depth_minimum_distance = value

    ##
    # When estimating the depth, the SDK uses this upper limit to turn higher values into TOO_FAR ones.
    # The current maximum distance that can be computed in the defined \ref UNIT
    # \note Changing this value has no impact on performance and doesn't affect the positional tracking nor the spatial mapping. (Only the depth, point cloud, normals)
    @property
    def depth_maximum_distance(self):
        return self.init.depth_maximum_distance

    @depth_maximum_distance.setter
    def depth_maximum_distance(self, float value):
        self.init.depth_maximum_distance = value

    ##
    # At initialization, the \ref Camera runs a self-calibration process that corrects small offsets from the device's factory calibration.
    # A drawback is that calibration parameters will sligtly change from one run to another, which can be an issue for repeatability.
    # If set to true, self-calibration will be disabled and calibration parameters won't be optimized.
    # default : false
    # \note In most situations, self calibration should remain enabled.
    @property
    def camera_disable_self_calib(self):
        return self.init.camera_disable_self_calib

    @camera_disable_self_calib.setter
    def camera_disable_self_calib(self, bool value):
        self.init.camera_disable_self_calib = value

    ##
    # If you are using the camera upside down, setting this parameter to true will cancel its rotation. The images will be horizontally flipped.
    # default : false
    @property
    def camera_image_flip(self):
        return self.init.camera_image_flip

    @camera_image_flip.setter
    def camera_image_flip(self, bool value):
        self.init.camera_image_flip = value

    ##
    # By default, the SDK only computes a single depth map, aligned with the left camera image.
    # This parameter allows you to enable the \ref DEPTH.DEPTH_RIGHT and other <XXX>.RIGHT at the cost of additional computation time.
    # For example, mixed reality passthrough applications require one depth map per eye, so this parameter can be activated.
    # default : false
    @property
    def enable_right_side_measure(self):
        return self.init.enable_right_side_measure

    @enable_right_side_measure.setter
    def enable_right_side_measure(self, bool value):
        self.init.enable_right_side_measure = value

    ##
    # When \ref sdk_verbose is enabled, this parameter allows you to redirect both the SDK verbose messages and your own application messages to a file.
    # default : (empty) Should contain the path to the file to be written. A file will be created if missing.
    # \note Setting this parameter to any value will redirect all standard output print calls of the entire program. This means that your own standard output print calls will be redirected to the log file.
    # \warning The log file won't be clear after successive executions of the application. This means that it can grow indefinitely if not cleared. 
    @property
    def sdk_verbose_log_file(self):
        if not self.init.sdk_verbose_log_file.empty():
            return self.init.sdk_verbose_log_file.get().decode()
        else:
            return ""

    @sdk_verbose_log_file.setter
    def sdk_verbose_log_file(self, str value):
        value_filename = value.encode()
        self.init.sdk_verbose_log_file.set(<char*>value_filename)

    ##
    # Regions of the generated depth map can oscillate from one frame to another. These oscillations result from a lack of texture (too homogeneous) on an object and by image noise.
    # This parameter enables a stabilization filter that reduces these oscilations.
    # default : true
    # \note The stabilization uses the positional tracking to increase its accuracy, so the Tracking module will be enabled automatically when set to true.
    #
    # Notice that calling \ref Camera.enable_tracking() with your own parameters afterward is still possible.
    @property
    def depth_stabilization(self):
        return self.init.depth_stabilization

    @depth_stabilization.setter
    def depth_stabilization(self, bool value):
        self.init.depth_stabilization = value

    ##
    # The SDK can handle different input types:
    #   - Select a camera by its ID (/dev/video<i>X</i> on Linux, and 0 to N cameras connected on Windows)
    #   - Select a camera by its serial number
    #   - Open a recorded sequence in the SVO file format
    #   - Open a streaming camera from its IP address and port
    #
    # This parameter allows you to select to desired input. It should be used like this:
    # \code
    # init_params = sl.InitParameters() # Set initial parameters
    # init_params.sdk_verbose = True # Enable verbose mode
    # input_t = sl.InputType()
    # input_t.set_from_camera_id(0) # Selects the camera with ID = 0
    # init_params.input = input_t
    # init_params.set_from_camera_id(0) # You can also use this
    # \endcode
    #
    # \code
    # init_params = sl.InitParameters() # Set initial parameters
    # init_params.sdk_verbose = True # Enable verbose mode
    # input_t = sl.InputType()
    # input_t.set_from_serial_number(1010) # Selects the camera with serial number = 101
    # init_params.input = input_t
    # init_params.set_from_serial_number(1010) # You can also use this
    # \endcode
    #
    # \code
    # init_params = sl.InitParameters() # Set initial parameters
    # init_params.sdk_verbose = True # Enable verbose mode
    # input_t = sl.InputType()
    # input_t.set_from_svo_file("/path/to/file.svo") # Selects the and SVO file to be read
    # init_params.input = input_t
    # init_params.set_from_svo_file("/path/to/file.svo")  # You can also use this
    # \endcode
    # 
    # \code
    # init_params = sl.InitParameters() # Set initial parameters
    # init_params.sdk_verbose = True # Enable verbose mode
    # input_t = sl.InputType()
    # input_t.set_from_stream("192.168.1.42")
    # init_params.input = input_t
    # init_params.set_from_stream("192.168.1.42") # You can also use this
    # \endcode
    #
    # Available cameras and their ID/serial can be listed using \ref get_device_list() and \ref get_streaming_device_list()
    # Each \ref Camera will create its own memory (CPU and GPU), therefore the number of ZED used at the same time can be limited by the configuration of your computer. (GPU/CPU memory and capabilities)
    #
    # default : empty
    # See \ref InputType for complementary information.
    # 
    # \warning Using the ZED SDK Python API, using init_params.input.set_from_XXX won't work, use init_params.set_from_XXX instead
    @property
    def input(self):
        input_t = InputType()
        input_t.input = self.init.input
        return input_t

    @input.setter
    def input(self, InputType input_t):
        self.init.input = input_t.input

    ##
    # Set the optional path where the SDK has to search for the settings files (SN<XXXX>.conf files). Those file contains the calibration of the camera.
    #
    # default : (empty). The SNXXX.conf file will be searched in the default directory (/usr/local/zed/settings/ for Linux or C:/ProgramData/stereolabs/settings for Windows)
    #
    # \note if a path is specified and no files has been found, the SDK will search on the default path (see default) for the *.conf file.
    #
    # Automatic download of conf file (through ZED Explorer or the installer) will still download the files on the default path. If you want to use another path by using this entry, make sure to copy the file in the proper location.
    #
    # \code
    # init_params = sl.InitParameters() # Set initial parameters
    # home = "/path/to/home"
    # path= home+"/Documents/settings/" # assuming /path/to/home/Documents/settings/SNXXXX.conf exists. Otherwise, it will be searched in /usr/local/zed/settings/
    # init_params.optional_settings_path = path
    # \endcode
    @property
    def optional_settings_path(self):
        if not self.init.optional_settings_path.empty():
            return self.init.optional_settings_path.get().decode()
        else:
            return ""

    @optional_settings_path.setter
    def optional_settings_path(self, str value):
        value_filename = value.encode()
        self.init.optional_settings_path.set(<char*>value_filename)

    ##
    # Call of \ref InputType.set_from_camera_id function of \ref input
    def set_from_camera_id(self, id):
        self.init.input.setFromCameraID(id)

    ##
    # Call of \ref InputType.set_from_serial_number function of \ref input
    def set_from_serial_number(self, serial_number):
        self.init.input.setFromSerialNumber(serial_number)

    ##
    # Call of \ref InputType.set_from_svo_file function of \ref input
    def set_from_svo_file(self, str svo_input_filename):
        filename = svo_input_filename.encode()
        self.init.input.setFromSVOFile(String(<char*> filename))

    ##
    # Call of \ref InputType.set_from_streamfunction of \ref input
    def set_from_stream(self, str sender_ip, port=30000):
        sender_ip_ = sender_ip.encode()
        self.init.input.setFromStream(String(<char*>sender_ip_), port)

##
# Parameters that defines the behavior of the \ref Camera.grab.
# \ingroup Depth_group
# Default values are enabled.
# You can customize it to fit your application and then save it to create a preset that can be loaded for further executions.
cdef class RuntimeParameters:
    cdef c_RuntimeParameters* runtime
    ##
    # Constructor.
    # \param sensing_mode : chosen \ref sensing_mode
    # \param enable_depth : activates \ref enable_depth
    # \param confidence_threshold : chosen \ref confidence_threshold
    # \param measure3D_reference_frame : chosen \ref measure3D_reference_frame
    #
    # \code
    # params = sl.RuntimeParameters(sensing_mode=SENSING_MODE.STANDARD, enable_depth=True)
    # \endcode
    def __cinit__(self, sensing_mode=SENSING_MODE.STANDARD, enable_depth=True,
                  confidence_threshold = 100, textureness_confidence_threshold = 100,
                  measure3D_reference_frame=REFERENCE_FRAME.CAMERA):
        if (isinstance(sensing_mode, SENSING_MODE) and isinstance(enable_depth, bool)
            and isinstance(confidence_threshold, int) and
            isinstance(measure3D_reference_frame, REFERENCE_FRAME)):

            self.runtime = new c_RuntimeParameters(<c_SENSING_MODE>(<unsigned int>sensing_mode.value), enable_depth, confidence_threshold, textureness_confidence_threshold,
                                                 <c_REFERENCE_FRAME>(<unsigned int>measure3D_reference_frame.value))
        else:
            raise TypeError()

    def __dealloc__(self):
        del self.runtime

    ##
    # Saves the current set of parameters into a file.
    # \param filename : the path to the file in which the parameters will be stored.
    # \return true if the file was successfully saved, otherwise false.
    def save(self, str filename):
        filename_save = filename.encode()
        return self.runtime.save(String(<char*> filename_save))

    ##
    # Loads the values of the parameters contained in a file.
    # \param filename : the path to the file from which the parameters will be loaded.
    # \return true if the file was successfully loaded, otherwise false.
    def load(self, str filename):
        filename_load = filename.encode()
        return self.runtime.load(String(<char*> filename_load))

    ##
    # Defines the algorithm used for depth map computation, more info : \ref SENSING_MODE definition.
    # default : \ref SENSING_MODE.STANDARD
    @property
    def sensing_mode(self):
        return SENSING_MODE(<int>self.runtime.sensing_mode)

    @sensing_mode.setter
    def sensing_mode(self, value):
        if isinstance(value, SENSING_MODE):
            self.runtime.sensing_mode = <c_SENSING_MODE>(<unsigned int>value.value)
        else:
            raise TypeError("Argument must be of SENSING_MODE type.")

    ##
    # Defines if the depth map should be computed.
    # If false, only the images are available.
    # default : true
    @property
    def enable_depth(self):
        return self.runtime.enable_depth

    @enable_depth.setter
    def enable_depth(self, bool value):
        self.runtime.enable_depth = value

    ##
    # Provides 3D measures (point cloud and normals) in the desired reference frame (default is REFERENCE_FRAME.CAMERA)
    # default : \ref REFERENCE_FRAME.CAMERA
    @property
    def measure3D_reference_frame(self):
        return REFERENCE_FRAME(<int>self.runtime.measure3D_reference_frame)

    @measure3D_reference_frame.setter
    def measure3D_reference_frame(self, value):
        if isinstance(value, REFERENCE_FRAME):
            self.runtime.measure3D_reference_frame = <c_REFERENCE_FRAME>(<unsigned int>value.value)
        else:
            raise TypeError("Argument must be of REFERENCE type.")

    ##
    # Threshold to reject depth values based on their confidence.
    # 
    # Each depth pixel has a corresponding confidence. (\ref MEASURE.CONFIDENCE)
    # A lower value means more confidence and precision (but less density). An upper value reduces filtering (more density, less certainty).
    # \n - \b setConfidenceThreshold(100) will allow values from \b 0 to \b 100. (no filtering)
    # \n - \b setConfidenceThreshold(90) will allow values from \b 10 to \b 100. (filtering lowest confidence values)
    # \n - \b setConfidenceThreshold(30) will allow values from \b 70 to \b 100. (keeping highest confidence values and lowering the density of the depth map)
    # The value should be in [1,100].
    # \n By default, the confidence threshold is set at 100, meaning that no depth pixel will be rejected.
    @property
    def confidence_threshold(self):
        return self.runtime.confidence_threshold

    @confidence_threshold.setter
    def confidence_threshold(self, value):
        self.runtime.confidence_threshold = value

    @property
    def textureness_confidence_threshold(self):
        return self.runtime.textureness_confidence_threshold

    @textureness_confidence_threshold.setter
    def textureness_confidence_threshold(self, value):
        self.runtime.textureness_confidence_threshold = value


##
# Parameters for positional tracking initialization.
# \ingroup PositionalTracking_group
# A default constructor is enabled and set to its default parameters.
# You can customize it to fit your application and then save it to create a preset that can be loaded for further executions.
# \note Parameters can be user adjusted.
cdef class PositionalTrackingParameters:
    cdef c_PositionalTrackingParameters* tracking
    ##
    # Constructor.
    # \param init_pos : chosen initial camera position in the world frame (\ref Transform)
    # \param _enable_memory : activates \ref enable_memory
    # \param _enable_pose_smoothing : activates \ref enable_pose_smoothing
    # \param _area_path : chosen \ref area_path
    # \param _set_floor_as_origin : activates \ref set_floor_as_origin
    # \param _enable_imu_fusion : activates \ref enable_imu_fusion
    # \param _set_as_static : activates \ref set_as_static
    #
    # \code
    # params = sl.PositionalTrackingParameters(init_pos=Transform()n _enable_pose_smoothing=True)
    # \endcode
    def __cinit__(self, Transform init_pos=Transform(), _enable_memory=True, _enable_pose_smoothing=False, _area_path=None,
                  _set_floor_as_origin=False, _enable_imu_fusion=True, _set_as_static=False):
        if _area_path is None:
            self.tracking = new c_PositionalTrackingParameters(init_pos.transform, _enable_memory, _enable_pose_smoothing, String(), _set_floor_as_origin, _enable_imu_fusion, _set_as_static)
        else :
            area_path = _area_path.encode()
            self.tracking = new c_PositionalTrackingParameters(init_pos.transform, _enable_memory, _enable_pose_smoothing, String(<char*> area_path), _set_floor_as_origin, _enable_imu_fusion, _set_as_static)
    
    def __dealloc__(self):
        del self.tracking

    ##
    # Saves the current set of parameters into a file.
    # \param filename : the path to the file in which the parameters will be stored.
    # \return true if the file was successfully saved, otherwise false.
    def save(self, str filename):
        filename_save = filename.encode()
        return self.tracking.save(String(<char*> filename_save))

    ##
    # Loads the values of the parameters contained in a file.
    # \param filename : the path to the file from which the parameters will be loaded.
    # \return true if the file was successfully loaded, otherwise false.
    def load(self, str filename):
        filename_load = filename.encode()
        return self.tracking.load(String(<char*> filename_load))

    ##
    # Get the position of the camera in the world frame when camera is started. By default it should be identity.
    # \param init_pos : \ref Transform to be returned, by default it creates one
    # \return Position of the camera in the world frame when camera is started.
    # \note The camera frame (defines the reference frame for the camera) is by default positioned at the world frame when tracking is started.
    def initial_world_transform(self, Transform init_pos = Transform()):
        init_pos.transform = self.tracking.initial_world_transform
        return init_pos

    ##
    # Set the position of the camera in the world frame when camera is started.
    # \param value : \ref Transform input
    def set_initial_world_transform(self, Transform value):
        self.tracking.initial_world_transform = value.transform

    ##
    # This mode enables the camera to learn and remember its surroundings. This helps correct positional tracking drift and position different cameras relative to each other in space.
    # default : true
    #
    # \warning This mode requires few resources to run and greatly improves tracking accuracy. We recommend to leave it on by default.
    @property
    def enable_area_memory(self):
        return self.tracking.enable_area_memory

    @enable_area_memory.setter
    def enable_area_memory(self, bool value):
        self.tracking.enable_area_memory = value

    ##
    # This mode enables smooth pose correction for small drift correction.
    # default : false
    @property
    def enable_pose_smoothing(self):
        return self.tracking.enable_pose_smoothing

    @enable_pose_smoothing.setter
    def enable_pose_smoothing(self, bool value):
        self.tracking.enable_pose_smoothing = value

    ##
    # This mode initialize the tracking aligned with the floor plane to better position the camera in space
    # \note The floor plane detection is launched in the background until it is found. The tracking is in SEARCHING state.
    # \warning This features work best with the ZED-M since it needs an IMU to classify the floor. The ZED needs to look at the floor during the initialization for optimum results.
    @property
    def set_floor_as_origin(self):
        return self.tracking.set_floor_as_origin

    @set_floor_as_origin.setter
    def set_floor_as_origin(self, bool value):
        self.tracking.set_floor_as_origin = value

    ##
    # This setting allows you to enable or disable the IMU fusion. When set to false, only the optical odometry will be used.
    # default : true
    # \note This setting has no impact on the tracking of a ZED camera, only the ZED Mini uses a built-in IMU.
    @property
    def enable_imu_fusion(self):
        return self.tracking.enable_imu_fusion

    @enable_imu_fusion.setter
    def enable_imu_fusion(self, bool value):
        self.tracking.enable_imu_fusion = value

    ##
    # Area localization file that describes the surroundings (previously saved).
    # default : (empty)
    # \note Loading an area file will start a searching phase during which the camera will try to position itself in the previously learned
    # \warning  area file describes a specific location. If you are using an area file describing a different location, the tracking function will continuously search for a position and may not find a correct one. The '.area' file can only be used with the same depth mode (MODE) as the one used during area recording.
    @property
    def area_file_path(self):
        if not self.tracking.area_file_path.empty():
            return self.tracking.area_file_path.get().decode()
        else:
            return ""

    @area_file_path.setter
    def area_file_path(self, str value):
        value_area = value.encode()
        self.tracking.area_file_path.set(<char*>value_area)

    ##
    # This setting allows you define the camera as static. If true, it will not move in the environment. This allows you to set its position using the initial world transform.
    # All SDK functionalities requiring positional tracking will be enabled.
    # \ref Camera.get_position() will return the value set as initial world transform for the PATH, and identify as the POSE.
    @property
    def set_as_static(self):
        return self.tracking.set_as_static

    @set_as_static.setter
    def set_as_static(self, bool value):
        self.tracking.set_as_static = value

##
# List of possible camera state.
# \ingroup Video_group
#
# | Enumerator |                 |
# |------------|-----------------|
# | H264 | AVCHD/H264 encoding used in image streaming. |
# | H265 | HEVC/H265 encoding used in image streaming. |
class STREAMING_CODEC(enum.Enum):
    H264 = <int>c_STREAMING_CODEC.STREAMING_CODEC_H264
    H265 = <int>c_STREAMING_CODEC.STREAMING_CODEC_H265
    LAST = <int>c_STREAMING_CODEC.STREAMING_CODEC_LAST

##
# Properties of a all streaming devices
# \ingroup Video_group
cdef class StreamingProperties:
    cdef c_StreamingProperties c_streaming_properties

    ##
    # the streaming IP of the device
    @property
    def ip(self):
        return to_str(self.c_streaming_properties.ip).decode()

    @ip.setter
    def ip(self, str ip_):
        self.c_streaming_properties.ip = String(ip_.encode())

    ##
    # the streaming port
    @property
    def port(self):
        return self.c_streaming_properties.port

    @port.setter
    def port(self, port_):
         self.c_streaming_properties.port = port_

    ##
    # the serial number of the streaming device
    @property
    def serial_number(self):
        return self.c_streaming_properties.serial_number

    @serial_number.setter
    def serial_number(self, serial_number):
        self.c_streaming_properties.serial_number=serial_number

    ##
    # the current bitrate of encoding of the streaming device
    @property
    def current_bitrate(self):
        return self.c_streaming_properties.current_bitrate

    @current_bitrate.setter
    def current_bitrate(self, current_bitrate):
        self.c_streaming_properties.current_bitrate=current_bitrate

    ##
    # the current codec used for compression in streaming device
    @property
    def codec(self):
        return STREAMING_CODEC(<int>self.c_streaming_properties.codec)

    @codec.setter
    def codec(self, codec):
        self.c_streaming_properties.codec = <c_STREAMING_CODEC>(<unsigned int>codec.value)


##
# Sets the streaming parameters.
# \ingroup Video_group
#
# The default constructor sets all parameters to their default settings.
# \note Parameters can be user adjusted.
cdef class StreamingParameters:
    cdef c_StreamingParameters* streaming
    ##
    # Constructor.
    # \param codec : the chosen \ref codec
    # \param port : the chosen \ref port
    # \param bitrate : the chosen \ref bitrate
    # \param gop_size : the chosen \ref gop_size
    # \param adaptative_bitrate : activtates \ref adaptative_bitrate
    # \param chunk_size : the chosen \ref chunk_size
    #
    # \code
    # params = sl.StreamingParameters(port=30000)
    # \endcode
    def __cinit__(self, codec=STREAMING_CODEC.H265, port=30000, bitrate=2000, gop_size=-1, adaptative_bitrate=False, chunk_size=32768):
            self.streaming = new c_StreamingParameters(<c_STREAMING_CODEC>(<unsigned int>codec.value), port, bitrate, gop_size, adaptative_bitrate, chunk_size)

    def __dealloc__(self):
        del self.streaming

    ##
    # Defines a single chunk size
    # \note Stream buffers are divided in X number of chunk where each chunk is "chunk_size" bits long.
    # \note Default value is 32768. You can lower this value if network generates a lot of packet lost : this will generates more chunk for a single image, but each chunk sent will be lighter to avoid inside-chunk corruption.
    # \note Available range : [8192 - 65000]
    @property
    def chunk_size(self):
        return self.streaming.chunk_size

    @chunk_size.setter
    def chunk_size(self, value):
        self.streaming.chunk_size = value

    ##
    # Defines the codec used for streaming.
    # \warning If HEVC is used, make sure the receiving host is compatible with H265 decoding (Pascal NVIDIA card or newer). If not, prefer to use H264 since every compatible NVIDIA card supports H264 decoding
    @property
    def codec(self):
        return STREAMING_CODEC(<int>self.streaming.codec)

    @codec.setter
    def codec(self, codec):
        self.streaming.codec = <c_STREAMING_CODEC>(<unsigned int>codec.value)

    ##
    # Defines the port the data will be streamed on.
    # \warning port must be an even number. Any odd number will be rejected.
    @property
    def port(self):
        return self.streaming.port

    @port.setter
    def port(self, unsigned short value):
        self.streaming.port = value

    ##
    # Defines the port the data will be streamed on.
    @property
    def bitrate(self):
        return self.streaming.bitrate

    @bitrate.setter
    def bitrate(self, unsigned int value):
        self.streaming.bitrate = value

    ##
    # Enable/Disable adaptive bitrate
    # \note Bitrate will be adjusted regarding the number of packet loss during streaming.
    # \note if activated, bitrate can vary between [bitrate/4, bitrate]
    # \warning Bitrate will be adjusted regarding the number of packet loss during streaming.
    @property
    def adaptative_bitrate(self):
        return self.streaming.adaptative_bitrate

    @adaptative_bitrate.setter
    def adaptative_bitrate(self, bool value):
        self.streaming.adaptative_bitrate = value

    ##
    # Defines the gop size in frame unit.
    # \note if value is set to -1, the gop size will match 2 seconds, depending on camera fps.
    # \note The gop size determines the maximum distance between IDR/I-frames. Very high GOP size will result in slightly more efficient compression, especially on static scene. But it can result in more latency if IDR/I-frame packet are lost during streaming.
    # \note Default value is -1. Maximum allowed value is 256 (frames).
    @property
    def gop_size(self):
        return self.streaming.gop_size

    @gop_size.setter
    def gop_size(self, int value):
        self.streaming.gop_size = value


##
# Sets the recording parameters.
# \ingroup Video_group
#
# The default constructor sets all parameters to their default settings.
# \note Parameters can be user adjusted.
cdef class RecordingParameters:

    cdef c_RecordingParameters *record
    ##
    # Constructor.
    # \param video_filename : the chosen \ref video_filename
    # \param compression_mode : the chosen \ref compression_mode
    #
    # \code
    # params = sl.RecordingParameters(video_filename="record.svo",compression_mode=SVO_COMPRESSION_MODE.H264)
    # \endcode
    def __cinit__(self, video_filename="myRecording.svo", compression_mode=SVO_COMPRESSION_MODE.H264):
        if (isinstance(compression_mode, SVO_COMPRESSION_MODE)) :
            video_filename_c = video_filename.encode()
            self.record = new c_RecordingParameters(String(<char*> video_filename_c), <c_SVO_COMPRESSION_MODE>(<unsigned int>compression_mode.value))
        else:
            raise TypeError()

    def __dealloc__(self):
        del self.record

    ##
    # filename of the SVO file.
    @property
    def video_filename(self):
        return to_str(self.record.video_filename).decode()

    @video_filename.setter
    def video_filename(self, video_filename):
        video_filename_c = video_filename.encode()
        self.record.video_filename = String(<char*> video_filename_c)

    ##
    # compression_mode : can be one of the \ref SVO_COMPRESSION_MODE enum
    @property
    def compression_mode(self):
        return SVO_COMPRESSION_MODE(<int>self.record.compression_mode)

    @compression_mode.setter
    def compression_mode(self, compression_mode):
        if isinstance(compression_mode, SVO_COMPRESSION_MODE) :
            self.record.compression_mode = <c_SVO_COMPRESSION_MODE>(<unsigned int>compression_mode.value)
        else :
            raise TypeError()

##
# Sets the spatial mapping parameters.
# \ingroup SpatialMapping_group
#
# Instantiating with the default constructor sets all parameters to their default values.
# You can customize these values to fit your application, and then save them to a preset to be loaded in future executions.
# \note Users can adjust these parameters as they see fit.
cdef class SpatialMappingParameters:
    cdef c_SpatialMappingParameters* spatial
    ##
    # Constructor.
    # \param resolution : the chosen \ref MAPPING_RESOLUTION
    # \param mapping_range : the chosen \ref MAPPING_RANGE
    # \param max_memory_usage : the chosen \ref max_memory_usage
    # \param save_texture : activates \ref save_texture
    # \param use_chunk_only : activates \ref use_chunk_only
    # \param reverse_vertex_order : activates \ref reverse_vertex_order
    # \param map_type : the chosen \ref map_type
    #
    # \code
    # params = sl.SpatialMappingParameters(resolution=MAPPING_RESOLUTION.HIGH)
    # \endcode
    def __cinit__(self, resolution=MAPPING_RESOLUTION.MEDIUM, mapping_range=MAPPING_RANGE.AUTO,
                  max_memory_usage=2048, save_texture=False, use_chunk_only=False,
                  reverse_vertex_order=False, map_type=SPATIAL_MAP_TYPE.MESH):
        if (isinstance(resolution, MAPPING_RESOLUTION) and isinstance(mapping_range, MAPPING_RANGE) and
            isinstance(use_chunk_only, bool) and isinstance(reverse_vertex_order, bool) and isinstance(map_type, SPATIAL_MAP_TYPE)):
            self.spatial = new c_SpatialMappingParameters(<c_MAPPING_RESOLUTION>(<unsigned int>resolution.value),
                                                          <c_MAPPING_RANGE>(<unsigned int>mapping_range.value),
                                                          max_memory_usage, save_texture,
                                                          use_chunk_only, reverse_vertex_order,
                                                          <c_SPATIAL_MAP_TYPE>(<unsigned int>map_type.value))
        else:
            raise TypeError()

    def __dealloc__(self):
        del self.spatial

    ##
    # Sets the resolution corresponding to the given \ref MAPPING_RESOLUTION preset.
    # \param resolution : the desired \ref MAPPING_RESOLUTION. default  \ref MAPPING_RESOLUTION.HIGH.
    def set_resolution(self, resolution=MAPPING_RESOLUTION.HIGH):
        if isinstance(resolution, MAPPING_RESOLUTION):
            self.spatial.set(<c_MAPPING_RESOLUTION> (<unsigned int>resolution.value))
        else:
            raise TypeError("Argument is not of MAPPING_RESOLUTION type.")

    ##
    # Sets the range corresponding to the given \ref MAPPING_RANGE preset.
    # \param mapping_range : the desired \ref MAPPING_RANGE . default : \ref MAPPING_RANGE.AUTO
    def set_range(self, mapping_range=MAPPING_RANGE.AUTO):
        if isinstance(mapping_range, MAPPING_RANGE):
            self.spatial.set(<c_MAPPING_RANGE> (<unsigned int>mapping_range.value))
        else:
            raise TypeError("Argument is not of MAPPING_RANGE type.")

    ##
    # Returns the maximum value of depth corresponding to the given \ref MAPPING_RANGE presets.
    # \param range : the desired \ref MAPPING_RANGE . default : \ref MAPPING_RANGE.AUTO
    # \return The maximum value of depth.
    def get_range_preset(self, mapping_range=MAPPING_RANGE.AUTO):
        if isinstance(mapping_range, MAPPING_RANGE):
            return self.spatial.get(<c_MAPPING_RANGE> (<unsigned int>mapping_range.value))
        else:
            raise TypeError("Argument is not of MAPPING_RANGE type.")

    ##
    # Returns the resolution corresponding to the given \ref MAPPING_RESOLUTION preset.
    # \param resolution : the desired \ref MAPPING_RESOLUTION . default : \ref MAPPING_RESOLUTION.HIGH
    # \return The resolution in meter
    def get_resolution_preset(self, resolution=MAPPING_RESOLUTION.HIGH):
        if isinstance(resolution, MAPPING_RESOLUTION):
            return self.spatial.get(<c_MAPPING_RESOLUTION> (<unsigned int>resolution.value))
        else:
            raise TypeError("Argument is not of MAPPING_RESOLUTION type.")

    ##
    # Returns the recommanded maximum depth value for the given \ref MAPPING_RESOLUTION preset
    # \param  mapping_resolution : the desired \ref MAPPING_RESOLUTION
    # \param py_cam : the \ref Camera object which will run the spatial mapping.
    # \return The maximum value of depth in meters.
    def get_recommended_range(self, resolution, Camera py_cam):
        if isinstance(resolution, MAPPING_RESOLUTION):
            return self.spatial.getRecommendedRange(<c_MAPPING_RESOLUTION> (<unsigned int>resolution.value), py_cam.camera)
        elif isinstance(resolution, float):
            return self.spatial.getRecommendedRange(<float> resolution, py_cam.camera)
        else:
            raise TypeError("Argument is not of MAPPING_RESOLUTION or float type.")

    ##
    # The type of spatial map to be created. This dictates the format that will be used for the mapping(e.g. mesh, point cloud). See \ref SPATIAL_MAP_TYPE
    @property
    def map_type(self):
        return SPATIAL_MAP_TYPE(<int>self.spatial.map_type)

    @map_type.setter
    def map_type(self, value):
        self.spatial.map_type = <c_SPATIAL_MAP_TYPE>(<unsigned int>value.value)

    ## 
    # The maximum CPU memory (in mega bytes) allocated for the meshing process.
    @property
    def max_memory_usage(self):
        return self.spatial.max_memory_usage

    @max_memory_usage.setter
    def max_memory_usage(self, int value):
        self.spatial.max_memory_usage = value

    ##
    # Set to true if you want to be able to apply the texture to your mesh after its creation.
    # \note This option will consume more memory.
    @property
    def save_texture(self):
        return self.spatial.save_texture

    @save_texture.setter
    def save_texture(self, bool value):
        self.spatial.save_texture = value

    ##
    # Set to false if you want to ensure consistency between the mesh and its inner chunk data.
    # \note Updating the mesh is time-consuming. Setting this to true results in better performance.
    @property
    def use_chunk_only(self):
        return self.spatial.use_chunk_only

    @use_chunk_only.setter
    def use_chunk_only(self, bool value):
        self.spatial.use_chunk_only = value

    ##
    # Specify if the order of the vertices of the triangles needs to be inverted. If your display process does not handle front and back face culling you can use this to set it right.
    @property
    def reverse_vertex_order(self):
        return self.spatial.reverse_vertex_order

    @reverse_vertex_order.setter
    def reverse_vertex_order(self, bool value):
        self.spatial.reverse_vertex_order = value

    ##
    # Gets the range of the minimal/maximal depth value allowed by the spatial mapping. (numpy array)
    # The first value of the array is the minimum value allowed.
    # The second value of the array is the maximum value allowed.
    @property
    def allowed_range(self):
        cdef np.ndarray arr = np.zeros(2)
        arr[0] = self.spatial.allowed_range.first
        arr[1] = self.spatial.allowed_range.second
        return arr

    ##
    # Depth range in meters. Can be different from the value set by \ref Camera.set_depth_max_range_value()
    # Set to 0 by default. In this case, the range is computed from resolution_meter and from the current internal parameters to fit your application.
    # Deprecated : Since SDK 2.6, we recommend leaving this to 0.
    @property
    def range_meter(self):
        return self.spatial.range_meter

    @range_meter.setter
    def range_meter(self, float value):
        self.spatial.range_meter = value

    ##
    # Gets the range of the maximal depth value allowed by the spatial mapping. (numpy array)
    # The first value of the array is the minimum value allowed.
    # The second value of the array is the maximum value allowed.
    @property
    def allowed_resolution(self):
        cdef np.ndarray arr = np.zeros(2)
        arr[0] = self.spatial.allowed_resolution.first
        arr[1] = self.spatial.allowed_resolution.second
        return arr

    ##
    # Spatial mapping resolution in meters, should fit \ref allowed_resolution
    @property
    def resolution_meter(self):
        return self.spatial.resolution_meter

    @resolution_meter.setter
    def resolution_meter(self, float value):
        self.spatial.resolution_meter = value

##
# Contains positional tracking data which gives the position and orientation of the ZED in 3D space.
# \ingroup PositionalTracking_group
# Different representations of position and orientation can be retrieved, along with timestamp and pose confidence.
cdef class Pose:
    cdef c_Pose pose
    def __cinit__(self):
        self.pose = c_Pose()

    ##
    # Deep copy from another \ref Pose
    # \param pose : the \ref Pose to copy
    def init_pose(self, Pose pose):
        self.pose = c_Pose(pose.pose)

    ##
    # Inits \ref Pose from pose data
    # 
    # \param pose_data : \ref Transform containing pose data to copy
    # \param mtimestamp : pose timestamp
    # \param mconfidence : pose confidence
    def init_transform(self, Transform pose_data, mtimestamp=0, mconfidence=0):
        self.pose = c_Pose(pose_data.transform, mtimestamp, mconfidence)

    ##
    # Returns the translation from the pose.
    # \param py_translation : \ref Translation to be returned. It creates one by default.
    # \return The (3x1) translation vector
    def get_translation(self, Translation py_translation = Translation()):
        py_translation.translation = self.pose.getTranslation()
        return py_translation

    ##
    # Returns the orientation from the pose.
    # \param py_orientation : \ref Orientation to be returned. It creates one by default.
    # \return The (3x1) orientation vector
    def get_orientation(self, Orientation py_orientation = Orientation()):
        py_orientation.orientation = self.pose.getOrientation()
        return py_orientation

    ##
    # Returns the rotation (3x3) from the pose.
    # \param py_rotation : \ref Rotation to be returned. It creates one by default.
    # \return The (3x3) rotation matrix
    # \warning The given \ref Rotation contains a copy of the \ref Transform values. Not references.
    def get_rotation_matrix(self, Rotation py_rotation = Rotation()):
        py_rotation.rotation = self.pose.getRotationMatrix()
        py_rotation.mat = self.pose.getRotationMatrix()
        return py_rotation

    ##
    # Returns the rotation (3x1) rotation vector obtained from 3x3 rotation matrix using Rodrigues formula) from the pose.
    # \return The (3x1) rotation vector (numpy array)
    def get_rotation_vector(self):
        cdef np.ndarray arr = np.zeros(3)
        for i in range(3):
            arr[i] = self.pose.getRotationVector()[i]
        return arr

    ##
    # Converts the \ref Rotation of the \ref Transform as Euler angles.
    # \param radian : Define if the angle in is radian or degree. default : true.
    # \return The Euler angles, as a float3 representing the rotations arround the X, Y and Z axes. (numpy array)
    def get_euler_angles(self, radian=True):
        cdef np.ndarray arr = np.zeros(3)
        if isinstance(radian, bool):
            for i in range(3):
                arr[i] = self.pose.getEulerAngles(radian)[i]
        else:
            raise TypeError("Argument is not of bool type.")
        return arr

    ##
    # boolean that indicates if tracking is activated or not. You should check that first if something wrong.
    @property
    def valid(self):
        return self.pose.valid

    @valid.setter
    def valid(self, bool valid_):
        self.pose.valid = valid_

    ##
    # \ref Timestamp of the pose. This timestamp should be compared with the camera timestamp for synchronization.
    @property
    def timestamp(self):
        """
        Timestamp of the pose. This timestamp should be compared with the camera timestamp for synchronization.
        """
        ts = Timestamp()
        ts.timestamp = self.pose.timestamp
        return ts

    @timestamp.setter
    def timestamp(self, unsigned long long timestamp):
        self.pose.timestamp.data_ns = timestamp

    ##
    # Gets the 4x4 Matrix which contains the rotation (3x3) and the translation. \ref Orientation is extracted from this transform as well.
    # \param pose data : \ref Transform to be returned. It creates one by default.
    # \return the pose data \ref Transform
    def pose_data(self, Transform pose_data = Transform()):
        pose_data.transform = self.pose.pose_data
        pose_data.mat = self.pose.pose_data
        return pose_data

    ##
    # Confidence/Quality of the pose estimation for the target frame.
    # A confidence metric of the tracking [0-100], 0 means that the tracking is lost, 100 means that the tracking can be fully trusted.
    @property
    def pose_confidence(self):
        return self.pose.pose_confidence

    @pose_confidence.setter
    def pose_confidence(self, int pose_confidence_):
        self.pose.pose_confidence = pose_confidence_

    ##
    # 6x6 Pose covariance of translation (the first 3 values) and rotation in so3 (the last 3 values) (numpy array)
    # \note Computed only if \ref PositionalTrackingParameters.enable_spatial_memory is disabled.
    @property
    def pose_covariance(self):
        cdef np.ndarray arr = np.zeros(36)
        for i in range(36) :
            arr[i] = self.pose.pose_covariance[i]
        return arr

    @pose_covariance.setter
    def pose_covariance(self, np.ndarray pose_covariance_):
        for i in range(36) :
            self.pose.pose_covariance[i] = pose_covariance_[i]


##
# Lists different states of the camera motion
#
# \ingroup Sensors_group
#
# | Enumerator     |                  |
# |------------|------------------|
# | STATIC | The camera is static. |
# | MOVING | The camera is moving. |
# | FALLING | The camera is falling. |
class CAMERA_MOTION_STATE(enum.Enum):
    STATIC = <int>c_CAMERA_MOTION_STATE.STATIC
    MOVING = <int>c_CAMERA_MOTION_STATE.MOVING
    FALLING = <int>c_CAMERA_MOTION_STATE.FALLING
    LAST = <int>c_CAMERA_MOTION_STATE.CAMERA_MOTION_STATE_LAST

##
# Defines the location of each sensor for \ref TemperatureData .
# \ingroup Sensors_group
#
# | Enumerator     |                  |
# |------------|------------------|
# | IMU | The IMU sensor location |
# | BAROMETER | The Barometer sensor location |
# | ONBOARD_LEFT | The Temperature sensor left location |
# | ONBOARD_RIGHT | The Temperature sensor right location |
class SENSOR_LOCATION(enum.Enum):
    IMU = <int>c_SENSOR_LOCATION.IMU
    BAROMETER = <int>c_SENSOR_LOCATION.BAROMETER
    ONBOARD_LEFT = <int>c_SENSOR_LOCATION.ONBOARD_LEFT
    ONBOARD_RIGHT = <int>c_SENSOR_LOCATION.ONBOARD_RIGHT
    LAST = <int>c_SENSOR_LOCATION.SENSOR_LOCATION_LAST

##
# Contains Barometer sensor data.
# \ingroup Sensors_group
cdef class BarometerData:
    cdef c_BarometerData barometerData

    def __cinit__(self):
        self.barometerData = c_BarometerData()

    ##
    # Defines if the sensor is available
    @property
    def is_available(self):
        return self.barometerData.is_available

    @is_available.setter
    def is_available(self, bool is_available):
        self.barometerData.is_available = is_available

    ##
    # Barometer ambient air pressure in hPa
    @property
    def pressure(self):
        return self.barometerData.pressure

    @pressure.setter
    def pressure(self, float pressure):
        self.barometerData.pressure=pressure

    ##
    # Relative altitude from first camera position (at open() time)
    @property
    def relative_altitude(self):
        return self.barometerData.relative_altitude

    @relative_altitude.setter
    def relative_altitude(self, float alt):
        self.barometerData.relative_altitude = alt

    ##
    # Defines the sensors data timestamp
    @property
    def timestamp(self):
        ts = Timestamp()
        ts.timestamp = self.barometerData.timestamp
        return ts

    @timestamp.setter
    def timestamp(self, unsigned long long timestamp):
        self.barometerData.timestamp.data_ns = timestamp


##
# Contains sensors' temperatures data.
# \ingroup Sensors_group
cdef class TemperatureData:
    cdef c_TemperatureData temperatureData

    def __cinit__(self):
        self.temperatureData = c_TemperatureData()

    ##
    # Gets temperature of sensor location
    # \param location : the sensor location ( \ref SENSOR_LOCAITON )
    # \return temperature of sensor location
    def get(self, location):
        cdef float value
        value = 0
        if isinstance(location,SENSOR_LOCATION):
            err = ERROR_CODE(<int>self.temperatureData.get(<c_SENSOR_LOCATION>(<unsigned int>(location.value)), value))
            if err == ERROR_CODE.SUCCESS :
                return value
            else :
                return -1
        else:
            raise TypeError("Argument not of type SENSOR_LOCATION")

##
# Contains magnetometer sensor data.
# \ingroup Sensors_group
cdef class MagnetometerData:
    cdef c_MagnetometerData magnetometerData

    def __cinit__(self):
        self.magnetometerData

    ##
    # Defines if the sensor is available
    @property
    def is_available(self):
        return self.magnetometerData.is_available

    @is_available.setter
    def is_available(self, bool is_available):
        self.magnetometerData.is_available = is_available

    ##
    # (3x1) Vector for magnetometer raw values (uncalibrated) In other words, the current magnetic field (uT), along with the x, y, and z axes.
    # \param magnetic_field : an array
    # \return the magnetic field array
    def get_magnetic_field_uncalibrated(self):
        cdef np.ndarray magnetic_field = np.zeros(3)
        for i in range(3):
            magnetic_field[i] = self.magnetometerData.magnetic_field_uncalibrated[i]
        return magnetic_field

    ##
    # (3x1) Vector for magnetometer values (using factory calibration). In other words, the current magnetic field (uT), along with the x, y, and z axes.
    # \param magnetic_field : an array
    # \return the magnetic field array
    def get_magnetic_field_calibrated(self):
        cdef np.ndarray magnetic_field = np.zeros(3)
        for i in range(3):
            magnetic_field[i] = self.magnetometerData.magnetic_field_calibrated[i]
        return magnetic_field

    ##
    # Defines the sensors data timestamp
    @property
    def timestamp(self):
        ts = Timestamp()
        ts.timestamp = self.magnetometerData.timestamp
        return ts

    @timestamp.setter
    def timestamp(self, unsigned long long timestamp):
        self.magnetometerData.timestamp.data_ns = timestamp


##
# Contains all sensors data (except image sensors) to be used for positional tracking or environment study.
# \ingroup Sensors_group
cdef class SensorsData:
    cdef c_SensorsData sensorsData

    def __cinit__(self):
        self.sensorsData = c_SensorsData()

    ##
    # Copy constructor.
    # \param sensorsData : \ref SensorsData object
    def init_sensorsData(self, SensorsData sensorsData):
        self.sensorsData = sensorsData.sensorsData

    ##
    # Indicates if the camera is static, moving or falling
    @property
    def camera_moving_state(self):
        return CAMERA_MOTION_STATE(<int>self.sensorsData.camera_moving_state)

    @camera_moving_state.setter
    def camera_moving_state(self, state):
        if isinstance(state, CAMERA_MOTION_STATE):
            self.sensorsData.camera_moving_state = <c_CAMERA_MOTION_STATE>(<unsigned int>(state.value))
        else:
            raise TypeError("Argument not of type CAMERA_MOVING_STATE")

    ##
    # Indicates if the Sensors data has been taken during a frame capture on sensor.
    # If value is 1, SensorsData has been taken during the same time than a frame has been acquired by the left sensor (the time precision is linked to the IMU rate, therefore 800Hz == 1.3ms)
    # If value is 0, the data has not been taken during a frame acquisition.
    @property
    def image_sync_trigger(self):
        return self.sensorsData.image_sync_trigger

    @image_sync_trigger.setter
    def image_sync_trigger(self, int image_sync_trigger):
        self.sensorsData.image_sync_trigger = image_sync_trigger


    ##
    # Gets the \ref IMUData
    # \return the \ref IMUData
    def get_imu_data(self):
        imu_data = IMUData()
        imu_data.imuData = self.sensorsData.imu
        return imu_data

    ##
    # Gets the \ref BarometerData
    # \return the \ref BarometerData
    def get_barometer_data(self):
        barometer_data = BarometerData()
        barometer_data.barometerData = self.sensorsData.barometer
        return barometer_data

    ##
    # Gets the \ref MagnetometerData
    # \return the \ref MagnetometerData
    def get_magnetometer_data(self):
        magnetometer_data = MagnetometerData()
        magnetometer_data.magnetometerData = self.sensorsData.magnetometer
        return magnetometer_data

    ##
    # Gets the \ref TemperatureData
    # \return the \ref TemperatureData
    def get_temperature_data(self):
        temperature_data = TemperatureData()
        temperature_data.temperatureData = self.sensorsData.temperature
        return temperature_data


##
# Contains the IMU sensor data.
# \ingroup Sensors_group
cdef class IMUData:
    cdef c_IMUData imuData

    def __cinit__(self):
        self.imuData = c_IMUData()
    
    ##
    # Gets the (3x1) Vector for angular velocity of the gyroscope, given in deg/s.
    # Values are corrected from bias, scale and misalignment.
    # In other words, the current velocity at which the sensor is rotating around the x, y, and z axes.
    # \note Those values can be directly ingested in a IMU fusion algorithm to extract quaternion
    # \param angular_velocity : A numpy array to be returned.
    # \return The angular velocity (3x1) vector in a numpy array
    def get_angular_velocity(self, angular_velocity):
        for i in range(3):
            angular_velocity[i] = self.imuData.angular_velocity[i]
        return angular_velocity

    ##
    # Gets the (3x1) Vector for linear acceleration of the gyroscope, given in m/s^2.
    # In other words, the current acceleration of the sensor, along with the x, y, and z axes.
    # \note Those values can be directly ingested in a IMU fusion algorithm to extract quaternion
    # \param linear_acceleration : A numpy array to be returned.
    # \return The linear acceleration (3x1) vector in a numpy array
    def get_linear_acceleration(self, linear_acceleration):
        for i in range(3):
            linear_acceleration[i] = self.imuData.linear_acceleration[i]
        return linear_acceleration

    ##
    # Gets the (3x3) Covariance matrix for angular velocity (x,y,z axes)
    # \param angular_velocity_covariance : \ref Matrix3f to be returned. It creates one by default.
    # \return The (3x3) Covariance matrix for angular velocity
    def get_angular_velocity_covariance(self, Matrix3f angular_velocity_covariance = Matrix3f()):
        angular_velocity_covariance.mat = self.imuData.angular_velocity_covariance
        return angular_velocity_covariance

    ##
    # Gets the (3x3) Covariance matrix for angular velocity (x,y,z axes)
    # \param angular_velocity_covariance : \ref Matrix3f to be returned. It creates one by default.
    # \return The (3x3) Covariance matrix for angular velocity
    def get_linear_acceleration_covariance(self, Matrix3f linear_acceleration_covariance = Matrix3f()):
        linear_acceleration_covariance.mat = self.imuData.linear_acceleration_covariance
        return linear_acceleration_covariance

    ##
    # boolean that indicates if tracking is activated or not. You should check that first if something wrong.
    @property
    def is_available(self):
        return self.imuData.is_available

    @is_available.setter
    def is_available(self, bool is_available):
        self.imuData.is_available = is_available

    ##
    # Defines the sensors data timestamp
    @property
    def timestamp(self):
        ts = Timestamp()
        ts.timestamp = self.imuData.timestamp
        return ts

    @timestamp.setter
    def timestamp(self, unsigned long long timestamp):
        self.imuData.timestamp.data_ns = timestamp

    ##
    # (3x3) 3x3 Covariance matrix for pose orientation (x,y,z axes)
    # \param pose_covariance : \ref Matrix3f  to be returned. It creates one by default.
    # \return the \ref Matrix3f to be returned
    def get_pose_covariance(self, Matrix3f pose_covariance = Matrix3f()):
        pose_covariance.mat = self.imuData.pose_covariance
        return pose_covariance


    ##
    # IMU pose (IMU 6-dof fusion)
    # \param pose : \ref Transform() to be returned. It creates one by default.
    # \return the \ref Transform to be returned
    def get_pose(self, Transform pose= Transform()):
        pose.transform = self.imuData.pose
        return pose

##
# Recording structure that contains information about SVO.
# \ingroup Video_group
cdef class RecordingStatus:
    cdef c_RecordingStatus recordingState

    ##
    # Recorder status, true if enabled
    @property
    def is_recording(self):
        return self.recordingState.is_recording

    @is_recording.setter
    def is_recording(self, bool value):
        self.recordingState.is_recording = value

    ##
    # Recorder status, true if the pause is enabled
    @property
    def is_paused(self):
        return self.recordingState.is_recording

    @is_paused.setter
    def is_paused(self, bool value):
        self.recordingState.is_paused = value

    ##
    # Status of current frame. True for success or false if the frame couldn't be written in the SVO file.
    @property
    def status(self):
        return self.recordingState.status

    @status.setter
    def status(self, bool value):
        self.recordingState.status = value

    ##
    # Compression time for the current frame in ms.
    @property
    def current_compression_time(self):
        return self.recordingState.current_compression_time

    @current_compression_time.setter
    def current_compression_time(self, double value):
        self.recordingState.current_compression_time = value

    ##
    # Compression ratio (% of raw size) for the current frame.
    @property
    def current_compression_ratio(self):
        return self.recordingState.current_compression_ratio

    @current_compression_ratio.setter
    def current_compression_ratio(self, double value):
        self.recordingState.current_compression_ratio = value

    ##
    # Average compression time in ms since beginning of recording.
    @property
    def average_compression_time(self):
        return self.recordingState.average_compression_time

    @average_compression_time.setter
    def average_compression_time(self, double value):
        self.recordingState.current_compression_time = value

    ##
    # Average compression ratio (% of raw size) since beginning of recording.
    @property
    def average_compression_ratio(self):
        return self.recordingState.average_compression_ratio

    @average_compression_ratio.setter
    def average_compression_ratio(self, double value):
        self.recordingState.average_compression_ratio = value


##
# This class is the main interface with the camera and the SDK features, such as: video, depth, tracking, mapping, and more. Find more information in the detailed description below.
# \ingroup Video_group
# 
# A standard program will use the \ref Camera class like this:
# \code
#
#        import pyzed.sl as sl
#
#        def main():
#            # --- Initialize a Camera object and open the ZED
#            # Create a ZED camera object
#            zed = sl.Camera()
#
#            # Set configuration parameters
#            init_params = sl.InitParameters()
#            init_params.camera_resolution = sl.RESOLUTION.HD720 #Use HD720 video mode
#            init_params.camera_fps = 60 # Set fps at 60
#
#            # Open the camera
#            err = zed.open(init_params)
#            if err != sl.ERROR_CODE.SUCCESS :
#                print(repr(err))
#                exit(-1)
#
#            runtime_param = sl.RuntimeParameters()
#            runtime_param.sensing_mode = sl.SENSING_MODE.STANDARD
#
#            # --- Main loop grabing images and depth values
#            # Capture 50 frames and stop
#            i = 0
#            image = sl.Mat()
#            depth = sl.Mat()
#            while i < 50 :
#                # Grab an image
#                if zed.grab(runtime_param) == sl.ERROR_CODE.SUCCESS : # A new image is available if grab() returns SUCCESS
#                    # Display a pixel color
#                    zed.retrieve_image(image, sl.VIEW.LEFT) # Get the left image
#                    center_rgb = image.get_value(image.get_width() / 2, image.get_height() / 2)
#                    print("Image ", i, " center pixel R:", int(center_rgb[0]), " G:", int(center_rgb[1]), " B:", int(center_rgb[2]))
#
#                    # Display a pixel depth
#                    zed.retrieve_measure(depth, sl.MEASURE.DEPTH) # Get the depth map
#                    center_depth = depth.get_value(depth.get_width() / 2, depth.get_height() /2)
#                    print("Image ", i," center depth:", center_depth)
#
#                    i = i+1
#
#            # --- Close the Camera
#            zed.close()
#            return 0
#
#        if __name__ == "__main__":
#            main()
#
# \endcode
cdef class Camera:
    cdef c_Camera camera
    def __cinit__(self):
        self.camera = c_Camera()
    
    ##
    # If \ref open() has been called, this function will close the connection to the camera (or the SVO file) and free the corresponding memory.
    #
    # If \ref open() wasn't called or failed, this function won't have any effects.
    # \note If an asynchronous task is running within the \ref Camera object, like \ref saveAreaMap(), this function will wait for its completion.
    # The \ref open() function can then be called if needed.
    # \warning If the CUDA context was created by \ref open(), this function will destroy it. Please make sure to delete your GPU \ref sl::Mat objects before the context is destroyed.
    def close(self):
        self.camera.close()

    ##
    # Opens the ZED camera from the provided \ref InitParameters.
    # This function will also check the hardware requirements and run a self-calibration.
    # \param py_init : a structure containing all the initial parameters. default : a preset of \ref InitParameters.
    # \return An error code giving information about the internal process. If \ref ERROR_CODE "SUCCESS" is returned, the camera is ready to use. Every other code indicates an error and the program should be stopped.
    #
    # Here is the proper way to call this function:
    #
    # \code
    # zed = sl.Camera() # Create a ZED camera object
    #
    # init_params = sl.InitParameters() # Set configuration parameters
    # init_params.camera_resolution = sl.RESOLUTION.HD720 # Use HD720 video mode
    # init_params.camera_fps = 60 # Set fps at 60
    #
    # # Open the camera
    # err = zed.open(init_params)
    # if (err != sl.ERROR_CODE.SUCCESS) :
    #   print(repr(err)) # Display the error
    #   exit(-1)
    # \endcode
    #
    # \note
    # If you are having issues opening a camera, the diagnostic tool provided in the SDK can help you identify to problems.
    # If this function is called on an already opened camera, \ref Camera.close() will be called.
    def open(self, InitParameters py_init=InitParameters()):
        if py_init:
            return ERROR_CODE(<int>self.camera.open(deref(py_init.init)))
        else:
            print("InitParameters must be initialized first with InitParameters().")


    ##
    # Reports if the camera has been successfully opened. It has the same behavior as checking if \ref open() returns \ref ERROR_CODE "SUCCESS".
    # \return true if the ZED is already setup, otherwise false.
    def is_opened(self):
        return self.camera.isOpened()

    ##
    # This function will grab the latest images from the camera, rectify them, and compute the measurements based on the \ref RuntimeParameters provided (depth, point cloud, tracking, etc.)
    # As measures are created in this function, its execution can last a few milliseconds, depending on your parameters and your hardware.
    # The exact duration will mostly depend on the following parameters:
    # 
    #   - \ref InitParameters.enable_right_side_measure : Activating this parameter increases computation time
    #   - \ref InitParameters.depth_mode : \ref DEPTH_MODE "PERFORMANCE" will run faster than \ref DEPTH_MODE "ULTRA"
    #   - \ref enable_positional_tracking() : Activating the tracking is an additional load
    #   - \ref RuntimeParameters.sensing_mode : \ref SENSING_MODE "STANDARD" mode will run faster than \ref SENSING_MODE "FILL" mode, which needs to estimate the depth of occluded pixels.
    #   - \ref RuntimeParameters.enable_depth : Avoiding the depth computation must be faster. However, it is required by most SDK features (tracking, spatial mapping, plane estimation, etc.)
    #
    # This function is meant to be called frequently in the main loop of your application.
    # \note Since ZED SDK 3.0, this function is blocking. It means that grab() will wait until a new frame is detected and available. If no new frames is available until timeout is reached, grab() will return \ref ERROR_CODE.CAMERA_NOT_DETECTED since the camera has probably been disconnected.
    # 
    # \param py_runtime : a structure containing all the runtime parameters. default : a preset of \ref RuntimeParameters.
    # \param Returning \ref ERROR_CODE "SUCCESS" means that no problem was encountered. Returned errors can be displayed using \ref toString(error)
    #
    # \code
    # # Set runtime parameters after opening the camera
    # runtime_param = sl.RuntimeParameters()
    # runtime_param.sensing_mode = sl.SENSING_MODE.STANDARD # Use STANDARD sensing mode
    #
    # image = sl.Mat()
    # while True :
    # # Grab an image
    # if zed.grab(runtime_param) == sl.ERROR_CODE.SUCCESS : # A new image is available if grab() returns SUCCESS
    #   zed.retrieve_image(image, sl.VIEW.LEFT) # Get the left image     
    #   # Use the image for your application
    # \endcode
    def grab(self, RuntimeParameters py_runtime=RuntimeParameters()):
        if py_runtime:
            return ERROR_CODE(<int>self.camera.grab(deref(py_runtime.runtime)))
        else:
            print("RuntimeParameters must be initialized first with RuntimeParameters().")

    ##
    # Retrieves images from the camera (or SVO file).
    #
    # Multiple images are available along with a view of various measures for display purposes.
    # Available images and views are listed \ref VIEW "here".
    # As an example, \ref VIEW "VIEW.DEPTH" can be used to get a gray-scale version of the depth map, but the actual depth values can be retrieved using \ref retrieve_measure() .
    #
    # <b>Memory</b>
    # By default, images are copied from GPU memory to CPU memory (RAM) when this function is called.
    # If your application can use GPU images, using the <b>type</b> parameter can increase performance by avoiding this copy.
    # If the provided \ref Mat object is already allocated  and matches the requested image format, memory won't be re-allocated.
    #
    # <b>Image size</b>
    # By default, images are returned in the resolution provided by \ref get_camera_information() in \ref CameraInformation.camera_resolution
    # However, you can request custom resolutions. For example, requesting a smaller image can help you speed up your application.
    # 
    # \param py_mat : \b [out] the \ref Mat to store the image.
    # \param view  : defines the image you want (see \ref VIEW). default : \ref VIEW "VIEW.LEFT".
    # \param type : whether the image should be provided in CPU or GPU memory. default : \ref MEM "MEM.CPU."
    # \param resolution : if specified, define the resolution of the output mat. If set to \ref Resolution (0,0) , the ZED resolution will be taken. default : (0,0).
    # \return An \ref ERROR_CODE :
    # \n - \ref ERROR_CODE.SUCCESS if the method succeeded,
    # \n - \ref ERROR_CODE.INVALID_FUNCTION_PARAMETERS if the view mode requires a module not enabled (\ref VIEW.DEPTH with \ref DEPTH_MODE.NONE for example),
    # \n - \ref ERROR_CODE.INVALID_RESOLUTION if the resolution is higher than \ref CameraInformation.camera_resolution provided by \ref get_camera_information() 
    #
    # \note As this function retrieves the images grabbed by the \ref grab() function, it should be called afterward.
    #
    # \code
    # # create sl.Mat objects to store the images
    # left_image = sl.Mat()
    # depth_view = sl.Mat()
    # while True :
    # # Grab an image
    # if zed.grab() == sl.ERROR_CODE.SUCCESS : # A new image is available if grab() returns SUCCESS
    #     zed.retrieve_image(left_image, sl.VIEW.LEFT) # Get the rectified left image
    #     zed.retrieve_image(depth_view, sl.VIEW.DEPTH) # Get a grayscale preview of the depth map
    #
    #     # Display the center pixel colors
    #     left_center = left_image.get_value(left_image.get_width() / 2, left_image.get_height() / 2)
    #     print("left_image center pixel R:", int(left_center[0]), " G:", int(left_center[1]), " B:", int(left_center[2]))
    #
    #     depth_center = depth_view.get_value(depth_view.get_width() / 2, depth_view.get_height() / 2)
    #     print("depth_view center pixel R:", int(depth_venter[1]), " G:", int(depth_center[1]), " B:", int(depth_center[2]))
    # \endcode
    def retrieve_image(self, Mat py_mat, view=VIEW.LEFT, type=MEM.CPU, Resolution resolution=Resolution(0,0)):
        if (isinstance(view, VIEW) and isinstance(type, MEM)):
            return ERROR_CODE(<int>self.camera.retrieveImage(py_mat.mat, <c_VIEW>(<unsigned int>view.value), <c_MEM>(<unsigned int>type.value), resolution.resolution))
        else:
            raise TypeError("Arguments must be of VIEW, MEM and integer types.")

    ##
    # Computed measures, like depth, point cloud, or normals, can be retrieved using this method.
    # 
    # Multiple measures are available after a :meth:`~pyzed.sl.Camera.grab()` call. A full list is available here.
    #
    # <b>Memory</b>
    # By default, images are copied from GPU memory to CPU memory (RAM) when this function is called.
    # If your application can use GPU images, using the \b type parameter can increase performance by avoiding this copy.
    # If the provided \ref Mat object is already allocated and matches the requested image format, memory won't be re-allocated.
    # 
    # <b>Measure size</b>
    # By default, measures are returned in the resolution provided by \ref get_camera_informations() in \ref CameraInformations.camera_resolution .
    # However, custom resolutions can be requested. For example, requesting a smaller measure can help you speed up your application.
    #
    # \param py_mat : \b [out] the \ref Mat to store the measures
    # \param measure : defines the measure you want. (see \ref MEASURE), default : \ref MEASURE "MEASURE.DEPTH"
    # \param type : the type of the memory of provided mat that should by used. default : \ref MEM.CPU.
    # \param resolution : if specified, define the resolution of the output mat. If set to \ref Resolution (0,0) , the ZED resolution will be taken. default : (0,0).
    # \return An \ref ERROR_CODE
    # \n - \ref ERROR_CODE.SUCCESS if the method succeeded,
    # \n - \ref ERROR_CODE.INVALID_FUNCTION_PARAMETERS if the view mode requires a module not enabled (\ref VIEW.DEPTH with \ref DEPTH_MODE.NONE for example),
    # \n - \ref ERROR_CODE.INVALID_RESOLUTION if the resolution is higher than \ref CameraInformation.camera_resolution provided by \ref get_camera_information() 
    # \n - \ref ERROR_CODE.FAILURE if another error occured.
    #
    # \note As this function retrieves the measures computed by the \ref grab() function, it should be called after.
    #
    # \code
    # depth_map = sl.Mat()
    # point_cloud = sl.Mat()
    # resolution = zed.get_camera_informations().camera_resolution
    # x = int(resolution.width / 2) # Center coordinates
    # y = int(resolution.height / 2)
    #
    # while True :
    #     if zed.grab() == sl.ERROR_CODE.SUCCESS : # Grab an image
    #
    #         zed.retrieve_measure(depth_map, sl.MEASURE.DEPTH, sl.MEM.CPU) # Get the depth map
    #
    #         # Read a depth value
    #         center_depth = depth_map.get_value(x, y sl.MEM.CPU) # each depth map pixel is a float value
    #         if isnormal(center_depth) : # + Inf is "too far", -Inf is "too close", Nan is "unknown/occlusion"
    #             print("Depth value at center: ", center_depth, " ", init_params.coordinate_units)
    #         zed.retrieve_measure(point_cloud, sl.MEASURE.XYZRGBA, sl.MEM.CPU) # Get the point cloud
    #
    #         # Read a point cloud value
    #         pc_value = point_cloud.get_value(x, y) # each point cloud pixel contains 4 floats, so we are using a numpy array
    #
    #         if (isnormal(pc_value[2])) :
    #             print("Point cloud coordinates at center: X=", pc_value[0], ", Y=", pc_value[1], ", Z=", pc_value[2])
    # \endcode
    def retrieve_measure(self, Mat py_mat, measure=MEASURE.DEPTH, type=MEM.CPU, Resolution resolution=Resolution(0,0)):
        if (isinstance(measure, MEASURE) and isinstance(type, MEM)):
            return ERROR_CODE(<int>self.camera.retrieveMeasure(py_mat.mat, <c_MEASURE>(<unsigned int>measure.value), <c_MEM>(<unsigned int>type.value), resolution.resolution))
        else:
            raise TypeError("Arguments must be of MEASURE, MEM and integer types.")

    ##
    # Sets the playback cursor to the desired frame number in the SVO file.
    #
    # This function allows you to move around within a played-back SVO file. After calling, the next call to \ref grab() will read the provided frame number.
    #
    # \param frame_number : the number of the desired frame to be decoded.
    # 
    # \note Works only if the camera is open in SVO playback mode.
    #
    # \code
    #
    # import pyzed.sl as sl
    #
    # def main() :
    #
    #     # Create a ZED camera object
    #     zed = sl.Camera()
    #
    #     # Set configuration parameters
    #     init_params = sl.InitParameters()
    #     init_params.set_from_svo_file("path/to/my/file.svo")
    #
    #     # Open the camera
    #     err = zed.open(init_params)
    #     if err != sl.ERROR_CODE.SUCCESS :
    #         print(repr(err))
    #         exit(-1)
    #
    #     # Loop between frame 0 and 50
    #     i = 0
    #     left_image = sl.Mat()
    #     while zed.get_svo_position() < zed.get_svo_number_of_frames()-1 :
    #
    #         print("Current frame: ", zed.get_svo_position())
    #
    #         # Loop if we reached frame 50
    #         if zed.get_svo_position() == 50 :
    #             zed.set_svo_position(0)
    #
    #         # Grab an image
    #         if zed.grab() == sl.ERROR_CODE.SUCCESS :
    #             zed.retrieve_image(left_image, sl.VIEW.LEFT) # Get the rectified left image
    #
    #         # Use the image in your application
    #
    #         # Close the Camera
    #         zed.close()
    #         return 0
    #
    # if __name__ == "__main__" :
    #     main()
    #
    # \endcode
    def set_svo_position(self, int frame_number):
        self.camera.setSVOPosition(frame_number)

    ##
    # Returns the current playback position in the SVO file.
    #
    # The position corresponds to the number of frames already read from the SVO file, starting from 0 to n.
    # 
    # Each \ref grab() call increases this value by one (except when using \ref InitParameters.svo_real_time_mode).
    # \return The current frame position in the SVO file. Returns -1 if the SDK is not reading an SVO.
    # 
    # \note Works only if the camera is open in SVO playback mode.
    #
    # See \ref set_svo_position() for an example.
    def get_svo_position(self):
        return self.camera.getSVOPosition()

    ##
    # Returns the number of frames in the SVO file.
    #
    # \return The total number of frames in the SVO file (-1 if the SDK is not reading a SVO).
    #
    # \note Works only if the camera is open in SVO reading mode.
    def get_svo_number_of_frames(self):
        return self.camera.getSVONumberOfFrames()

    ##
    # Sets the value of the requested \ref VIDEO_SETTINGS "camera setting". (gain, brightness, hue, exposure, etc.)
    #
    # Possible values (range) of each setting are available \ref VIDEO_SETTINGS "here".
    #
    # \param settings : the setting to be set
    # \param value : the value to set, default : auto mode
    #
    # \code
    # # Set the gain to 50
    # zed.set_camera_settings(sl.VIDEO_SETTINGS.GAIN, 50)
    # \endcode
    #
    # \warning Setting \ref VIDEO_SETTINGS.EXPOSURE or \ref VIDEO_SETTINGS.GAIN to default will automatically sets the other to default.
    #
    # \note Works only if the camera is opened in live mode.
    def set_camera_settings(self, settings, int value=-1):
        if isinstance(settings, VIDEO_SETTINGS) :
            self.camera.setCameraSettings(<c_VIDEO_SETTINGS>(<unsigned int>settings.value), value)
        else:
            raise TypeError("Arguments must be of VIDEO_SETTINGS and boolean types.")

    ##
    # Returns the current value of the requested \ref VIDEO_SETTINGS "camera setting". (gain, brightness, hue, exposure, etc.)
    # 
    # Possible values (range) of each setting are available \ref VIDEO_SETTINGS "here".
    # 
    # \param setting : the requested setting.
    # \return The current value for the corresponding setting. Returns -1 if encounters an error.
    #
    # 
    # \code
    # gain = zed.get_camera_settings(sl.VIDEO_SETTINGS.GAIN)
    # print("Current gain value: ", gain)
    # \endcode
    #
    # \note Works only if the camera is open in live mode. (Settings aren't exported in the SVO file format)
    def get_camera_settings(self, setting):
        if isinstance(setting, VIDEO_SETTINGS):
            return self.camera.getCameraSettings(<c_VIDEO_SETTINGS>(<unsigned int>setting.value))
        else:
            raise TypeError("Argument is not of VIDEO_SETTINGS type.")

    ##
    # Returns the current framerate at which the \ref grab() method is successfully called.
    #
    # The returned value is based on the difference of camera \ref get_timestamp() "timestamps" between two successful grab() calls.
    #
    # \return The current SDK framerate
    #
    # \warning The returned framerate (number of images grabbed per second) can be lower than \ref InitParameters.camera_fps if the \ref grab() function runs slower than the image stream or is called too often.
    #
    # \code
    # current_fps = zed.get_current_fps()
    # print("Current framerate: ", current_fps)
    # \endcode
    def get_current_fps(self):
        return self.camera.getCurrentFPS()

    ##
    # Returns the timestamp in the requested \ref TIME_REFERENCE
    #
    # - When requesting the \ref TIME_REFERENCE.IMAGE timestamp, the UNIX nanosecond timestamp of the latest \ref grab() "grabbed" image will be returned.
    # This value corresponds to the time at which the entire image was available in the PC memory. As such, it ignores the communication time that corresponds to 2 or 3 frame-time based on the fps (ex: 33.3ms to 50ms at 60fps).
    #
    # - When requesting the \ref TIME_REFERENCE.CURRENT timestamp, the current UNIX nanosecond timestamp is returned.
    #
    # This function can also be used when playing back an SVO file.
    #
    # \param time_reference : The selected \ref TIME_REFERENCE.
    # \return The \ref Timestamp in nanosecond. 0 if not available (SVO file without compression).
    #
    # \note As this function returns UNIX timestamps, the reference it uses is common across several \ref Camera instances.
    #
    # \code
    # last_image_timestamp = zed.get_timestamp(sl.TIME_REFERENCE.IMAGE)
    # current_timestamp = zed.get_timestamp(sl.TIME_REFERENCE.CURRENT)
    # print("Latest image timestamp: ", last_image_timestamp.get_nanoseconds(), "ns from Epoch.")
    # print("Current timestamp: ", current_timestamp.get_nanoseconds(), "ns from Epoch.")
    # \endcode 
    def get_timestamp(self, time_reference):
        if isinstance(time_reference, TIME_REFERENCE):
            ts = Timestamp()
            ts.timestamp = self.camera.getTimestamp(<c_TIME_REFERENCE>(<unsigned int>time_reference.value))
            return ts
        else:
            raise TypeError("Argument is not of TIME_REFERENCE type.")

    ##
    # Returns the number of frames dropped since \ref grab() was called for the first time.
    #
    # A dropped frame corresponds to a frame that never made it to the grab function.
    # This can happen if two frames were extracted from the camera when grab() is called. The older frame will be dropped so as to always use the latest (which minimizes latency)
    # \return The number of frames dropped since the first \ref grab() call.
    def get_frame_dropped_count(self):
        return self.camera.getFrameDroppedCount()

    ##
    # Returns the calibration parameters, serial number and other information about the camera being used.
    # As calibration parameters depend on the image resolution, you can provide a custom resolution as a parameter to get scaled information.
    # When reading an SVO file, the parameters will correspond to the camera used for recording.
    # 
    # \param resizer : You can specify a size different from default image size to get the scaled camera information. default = (0,0) meaning original image size.
    # \return \ref CameraInformation containing the calibration parameters of the ZED, as well as serial number and firmware version.
    #
    # \note The returned parameters might vary between two execution due to the \ref InitParameters.camera_disable_self_calib "self-calibration" being ran in the \ref open() method.
    def get_camera_information(self, resizer = Resolution(0, 0)):
        return CameraInformation(self, resizer)

    ##
    # Returns the runtime parameters used. Correspond to the structure send when the \ref grab() function was called
    # \return \ref RuntimeParameters containing the parameters that defines the behavior of the \ref grab()
    def get_runtime_parameters(self) :
        runtime = RuntimeParameters()
        runtime.runtime.sensing_mode = self.camera.getRuntimeParameters().sensing_mode
        runtime.runtime.measure3D_reference_frame = self.camera.getRuntimeParameters().measure3D_reference_frame
        runtime.runtime.enable_depth = self.camera.getRuntimeParameters().enable_depth
        runtime.runtime.confidence_threshold = self.camera.getRuntimeParameters().confidence_threshold

        return runtime

    ##
    # Returns the init parameters used. Correspond to the structure send when the \ref open() function was called
    #
    # \return \ref InitParameters containing the parameters used to initialize the \ref Camera object.
    def get_init_parameters(self) :
        init = InitParameters()
        init.init.camera_resolution = self.camera.getInitParameters().camera_resolution
        init.init.camera_fps = self.camera.getInitParameters().camera_fps
        init.init.camera_image_flip = self.camera.getInitParameters().camera_image_flip
        init.init.camera_disable_self_calib = self.camera.getInitParameters().camera_disable_self_calib
        init.init.enable_right_side_measure = self.camera.getInitParameters().enable_right_side_measure
        init.init.svo_real_time_mode = self.camera.getInitParameters().svo_real_time_mode
        init.init.depth_mode = self.camera.getInitParameters().depth_mode
        init.init.depth_stabilization = self.camera.getInitParameters().depth_stabilization
        init.init.depth_minimum_distance = self.camera.getInitParameters().depth_minimum_distance
        init.init.depth_maximum_distance = self.camera.getInitParameters().depth_maximum_distance
        init.init.coordinate_units = self.camera.getInitParameters().coordinate_units
        init.init.coordinate_system = self.camera.getInitParameters().coordinate_system
        init.init.sdk_gpu_id = self.camera.getInitParameters().sdk_gpu_id
        init.init.sdk_verbose = self.camera.getInitParameters().sdk_verbose
        init.init.sdk_verbose_log_file = self.camera.getInitParameters().sdk_verbose_log_file
        init.init.input = self.camera.getInitParameters().input
        init.init.optional_settings_path = self.camera.getInitParameters().optional_settings_path
        return init

    ##
    # Returns the positional tracking parameters used. Correspond to the structure send when the \ref Camera.enable_positional_tracking() function was called.
    #
    # \return \ref PositionalTrackingParameters containing the parameters used for positional tracking initialization.
    def get_positional_tracking_parameters(self) :
        tracking = PositionalTrackingParameters()
        tracking.tracking.initial_world_transform = self.camera.getPositionalTrackingParameters().initial_world_transform
        tracking.tracking.enable_area_memory = self.camera.getPositionalTrackingParameters().enable_area_memory
        tracking.tracking.enable_pose_smoothing = self.camera.getPositionalTrackingParameters().enable_pose_smoothing
        tracking.tracking.set_floor_as_origin = self.camera.getPositionalTrackingParameters().set_floor_as_origin
        tracking.tracking.area_file_path = self.camera.getPositionalTrackingParameters().area_file_path
        tracking.tracking.enable_imu_fusion  = self.camera.getPositionalTrackingParameters().enable_imu_fusion
        tracking.tracking.set_as_static = self.camera.getPositionalTrackingParameters().set_as_static
        return tracking

    ## 
    # Returns the spatial mapping parameters used. Correspond to the structure send when the \ref Camera.enable_spatial_mapping() function was called.
    #
    # \return \ref SpatialMappingParameters containing the parameters used for spatial mapping initialization.
    def get_spatial_mapping_parameters(self) :
        spatial = SpatialMappingParameters()
        spatial.spatial.resolution_meter =  self.camera.getSpatialMappingParameters().resolution_meter
        spatial.spatial.range_meter =  self.camera.getSpatialMappingParameters().range_meter
        spatial.spatial.save_texture =  self.camera.getSpatialMappingParameters().save_texture
        spatial.spatial.use_chunk_only =  self.camera.getSpatialMappingParameters().use_chunk_only
        spatial.spatial.max_memory_usage =  self.camera.getSpatialMappingParameters().max_memory_usage
        spatial.spatial.reverse_vertex_order =  self.camera.getSpatialMappingParameters().reverse_vertex_order
        spatial.spatial.map_type =  self.camera.getSpatialMappingParameters().map_type
        return spatial

    ##
    # Returns the object detection parameters used. Correspond to the structure send when the \ref Camera.enable_object_detection() function was called
    #
    # \return \ref ObjectDetectionParameters containing the parameters used for object detection initialization.
    def get_object_detection_parameters(self) :
        object_detection = ObjectDetectionParameters()
        object_detection.object_detection.image_sync = self.camera.getObjectDetectionParameters().image_sync
        object_detection.object_detection.enable_tracking = self.camera.getObjectDetectionParameters().enable_tracking
        return object_detection

    ##
    # Returns the streaming parameters used. Correspond to the structure send when the \ref Camera.enable_streaming() function was called.
    # 
    # \return \ref StreamingParameters containing the parameters used for streaming initialization.
    def get_streaming_parameters(self):
        stream = StreamingParameters()
        stream.streaming.codec = self.camera.getStreamingParameters().codec
        stream.streaming.port = self.camera.getStreamingParameters().port
        stream.streaming.bitrate = self.camera.getStreamingParameters().bitrate
        stream.streaming.gop_size = self.camera.getStreamingParameters().gop_size
        stream.streaming.adaptative_bitrate = self.camera.getStreamingParameters().adaptative_bitrate
        return stream

    ##
    # Initializes and starts the positional tracking processes.
    #
    # This function allows you to enable the position estimation of the SDK. It only has to be called once in the camera's lifetime.
    #
    # When enabled, the position will be update at each grab call.
    # Tracking-specific parameter can be set by providing
    #
    # \param py_tracking : structure containing all the \ref PositionalTrackingParameters . default : a preset of \ref PositionalTrackingParameters.
    # \return \ref ERROR_CODE.FAILURE if the \ref area_file_path file wasn't found, \ref ERROR_CODE.SUCCESS otherwise.
    #
    # \warning The positional tracking feature benefits from a high framerate. We found HD720@60fps to be the best compromise between image quality and framerate.
    #
    # \code
    #
    # import pyzed.sl as sl
    # def main() :
    #     # --- Initialize a Camera object and open the ZED
    #     # Create a ZED camera object
    #     zed = sl.Camera()
    #
    #     # Set configuration parameters
    #     init_params = sl.InitParameters()
    #     init_params.camera_resolution = sl.RESOLUTION.HD720 # Use HD720 video mode
    #     init_params.camera_fps = 60 # Set fps at 60
    # 
    #     # Open the camera
    #     err = zed.open(init_params)
    #     if err != sl.ERROR_CODE.SUCCESS :
    #         print(repr(err))
    #         exit(-1)
    # 
    #     # Set tracking parameters
    #     track_params = sl.PositionalTrackingParameters()
    #     track_params.enable_spatial_memory = True
    #
    #     # Enable positional tracking
    #     err = zed.enable_tracking(track_params)
    #     if err != sl.ERROR_CODE.SUCCESS :
    #         print("Tracking error: ", repr(err))
    #         exit(-1)
    #
    #     # --- Main loop
    #     while True :
    #         if zed.grab() == sl.ERROR_CODE.SUCCESS : # Grab an image and computes the tracking
    #             camera_pose = sl.Pose()
    #             zed.get_position(camera_pose, sl.REFERENCE_FRAME.WORLD)
    #             print("Camera position: X=", camera_pose.get_translation()[0], " Y=", camera_pose.get_translation()[1], " Z=", camera_pose.get_translation()[2])
    #
    #     # --- Close the Camera
    #     zed.close()
    #     return 0
    #
    # if __name__ == "__main__" :
    #     main()
    #
    # \endcode
    def enable_positional_tracking(self, PositionalTrackingParameters py_tracking=PositionalTrackingParameters()):
        if py_tracking:
            return ERROR_CODE(<int>self.camera.enablePositionalTracking(deref(py_tracking.tracking)))
        else:
            print("PositionalTrackingParameters must be initialized first with PositionalTrackingParameters().")

    ##
    # Retrieves the Sensors (IMU,magnetometer,barometer) Data at a specific time reference
    # 
    # Calling \ref get_sensors_data with \ref TIME_REFERENCE "TIME_REFERENCE.CURRENT" gives you the latest sensors data received. Getting all the data requires to call this function at 800Hz in a thread.
    # Calling \ref get_sensors_data with \ref TIME_REFERENCE "TIME_REFERENCE.IMAGE" gives you the sensors data at the time of the latest image \ref grab() "grabbed".
    #
    # \ref SensorsData object object contains the previous \ref IMUData structure that was used in ZED SDK v2.X:
    # For IMU data, the values are provided in 2 ways :
    # <b>Time-fused</b> pose estimation that can be accessed using:
    #   <ul><li>\ref data.imu.pose</li>
    # <b>Raw values</b> from the IMU sensor:
    #   <ul><li>\ref data.imu.angular_velocity, corresponding to the gyroscope</li>
    #   <li>\ref data.imu.linear_acceleration, corresponding to the accelerometer</li></ul>
    # both gyroscope and accelerometer are synchronized. The delta time between previous and current value can be calculated using <li>\ref data.imu.timestamp</li>
    #
    # \note The IMU quaternion (fused data) is given in the specified \ref COORDINATE_SYSTEM of \ref InitParameters.
    #
    # \warning In SVO reading mode, the \ref TIME_REFERENCE.CURRENT is currently not available (yielding \ref ERROR_CODE.INVALID_FUNCTION_PARAMETERS .
    # * Only the quaternion data and barometer data (if available) at \ref TIME_REFERENCE.IMAGE are available. Other values will be set to 0.
    #
    def get_sensors_data(self, SensorsData py_sensors_data, time_reference = TIME_REFERENCE.CURRENT):
        if isinstance(time_reference, TIME_REFERENCE):
            return ERROR_CODE(<int>self.camera.getSensorsData(py_sensors_data.sensorsData, <c_TIME_REFERENCE>(<unsigned int>time_reference.value)))
        else:
            raise TypeError("Argument is not of TIME_REFERENCE type.")

    ##
    # Set an optional IMU orientation hint that will be used to assist the tracking during the next \ref grab().
    # 
    # This function can be used to assist the positional tracking rotation while using a ZED Mini.
    # 
    # \note This function is only effective if a ZED Mini (ZED-M) is used.
    # 
    # It needs to be called before the \ref grab() function.
    # \param transform : \ref Transform to be ingested into IMU fusion. Note that only the rotation is used.
    # \return \ref ERROR_CODE.SUCCESS if the transform has been passed, \ref ERROR_CODE.INVALID_FUNCTION_CALL otherwise (such as when use with the ZED camera due to its lack of an IMU).
    def set_imu_prior(self, Transform transfom):
        return ERROR_CODE(<int>self.camera.setIMUPrior(transfom.transform))

    ##
    # Retrieves the estimated position and orientation of the camera in the specified \ref REFERENCE_FRAME "reference frame".
    #
    # Using \ref REFERENCE_FRAME "REFERENCE_FRAME.WORLD", the returned pose relates to the initial position of the camera.  (\ref PositionalTrackingParameters.initial_world_transform )
    # Using \ref REFERENCE_FRAME "REFERENCE_FRAME.CAMERA", the returned pose relates to the previous position of the camera.
    #
    # If the tracking has been initialized with \ref PositionalTrackingParameters.enable_area_memory to true (default), this function can return \ref POSITIONAL_TRACKING_STATE "POSITIONAL_TRACKING_STATE::SEARCHING".
    # This means that the tracking lost its link to the initial referential and is currently trying to relocate the camera. However, it will keep on providing position estimations.
    # 
    # \param camera_pose \b [out]: the pose containing the position of the camera and other information (timestamp, confidence)
    # \param reference_frame : defines the reference from which you want the pose to be expressed. Default : \ref REFERENCE_FRAME "REFERENCE_FRAME::WORLD".
    # \return The current \ref POSITIONAL_TRACKING_STATE "state" of the tracking process.
    #
    # Extract Rotation Matrix : camera_pose.get_rotation()
    # Extract Translation Vector : camera_pose.get_translation()
    # Extract Orientation / quaternion : camera_pose.get_orientation()
    #
    # \code
    # while True :
    # if zed.grab() == sl.ERROR_CODE.SUCCESS : # Grab an image and computes the tracking
    #     camera_pose = sl.Pose()
    #     zed.get_position(camera_pose, sl.REFERENCE_FRAME.WORLD)
    #
    #     print("Camera position: X=", camera_pose.get_translation().[0], " Y=", camera_pose.get_translation()[1], " Z=", camera_pose.get_translation()[2])
    #     print("Camera Euler rotation: X=", camera_pose.get_euler_angles()[0], " Y=", camera_pose.get_euler_angles()[1], " Z=", camera_pose.get_euler_angles()[2])
    #     print("Camera Rodrigues rotation: X=", camera_pose.get_rotation_vector()[0], " Y=", camera_pose.get_rotation_vector()[1], " Z=", camera_pose.get_rotation_vector()[2])
    #     print("Camera quaternion orientation: X=", camera_pose.get_orientation()[0], " Y=", camera_pose.get_orientation()[1], " Z=", camera_pose.get_orientation()[2], " W=", camera_pose.get_orientation()[3])
    # \endcode
    def get_position(self, Pose py_pose, reference_frame = REFERENCE_FRAME.WORLD):
        if isinstance(reference_frame, REFERENCE_FRAME):
            return POSITIONAL_TRACKING_STATE(<int>self.camera.getPosition(py_pose.pose, <c_REFERENCE_FRAME>(<unsigned int>reference_frame.value)))
        else:
            raise TypeError("Argument is not of REFERENCE_FRAME type.")

    ##
    # Returns the state of the spatial memory export process.
    #
    # As \ref Camera.save_area_map() only starts the exportation, this function allows you to know when the exportation finished or if it failed.
    # \return The current \ref AREA_EXPORTING_STATE "state" of the spatial memory export process.
    def get_area_export_state(self):
        return AREA_EXPORTING_STATE(<int>self.camera.getAreaExportState())

    ##
    # Saves the current area learning file. The file will contain spatial memory data generated by the tracking.
    #
    # If the tracking has been initialized with \ref PositionalTrackingParameters.enable_area_memory to true (default), the function allows you to export the spatial memory.
    # Reloading the exported file in a future session with \ref PositionalTrackingParameters.area_file_path initialize the tracking within the same referential.
    # This function is asynchronous, and only triggers the file generation. You can use \ref get_area_export_state() to get the export state.
    # The positional tracking keeps running while exporting.
    #
    # \param area_file_path : saves the spatial memory database in an '.area' file.
    # \return \ref ERROR_CODE "ERROR_CODE.FAILURE" if the \ref area_file_path file wasn't found, \ref ERROR_CODE.SUCCESS otherwise.
    # 
    # See \reg get_area_export_state()
    #
    # \note Please note that this function will also flush the area database that was built / loaded.
    # 
    # \warning If the camera wasn't moved during the tracking session, or not enough, the spatial memory won't be usable and the file won't be exported.
    # The \ref get_area_export_state() will return \ref AREA_EXPORTING_STATE "AREA_EXPORTING_STATE.NOT_STARTED"
    # A few meters (~3m) of translation or a full rotation should be enough to get usable spatial memory.
    # However, as it should be used for relocation purposes, visiting a significant portion of the environment is recommended before exporting.
    #
    # \code
    # while True :
    #     if zed.grab() == sl.ERROR_CODE.SUCCESS : # Grab an image and computes the tracking
    #         camera_pose = Pose()
    #         zed.get_position(camera_pose, REFERENCE_FRAME.WORLD)
    #
    # # Export the spatial memory for future sessions
    # zed.save_area_map("office.area") # The actual file will be created asynchronously.
    # print(repr(zed.get_area_export_state()))
    #
    # # Close the camera
    # zed.close();
    # \endcode
    def save_area_map(self, str area_file_path=""):
        filename = area_file_path.encode()
        return ERROR_CODE(<int>self.camera.saveAreaMap(String(<char*>filename)))

    ##
    # Disables the positional tracking.
    #
    # The positional tracking is immediately stopped. If a file path is given, \ref save_area_map() will be called asynchronously. See \ref get_area_export_state() to get the exportation state.
    # If the tracking has been enabled, this function will automatically be called by \ref close() .
    # 
    # \param area_file_path : if set, saves the spatial memory into an '.area' file. default : (empty)
    # area_file_path is the name and path of the database, e.g. "path/to/file/myArea1.area".
    #
    # \note The '.area' database depends on the depth map SENSING_MODE chosen during the recording. The same mode must be used to reload the database.
    def disable_positional_tracking(self, str area_file_path=""):
        filename = area_file_path.encode()
        self.camera.disablePositionalTracking(String(<char*> filename))

    ##
    # Resets the tracking, and re-initializes the position with the given transformation matrix.
    # \param path : Position of the camera in the world frame when the function is called. By default, it is set to identity.
    # \return \ref ERROR_CODE "ERROR_CODE.FAILURE"  if the \ref area_file_path file wasn't found, \ref ERROR_CODE.SUCCESS otherwise.
    #
    # \note Please note that this function will also flush the accumulated or loaded spatial memory.
    def reset_positional_tracking(self, Transform path):
        return ERROR_CODE(<int>self.camera.resetPositionalTracking(path.transform))

    ##
    # Initializes and starts the spatial mapping processes.
    #
    # The spatial mapping will create a geometric representation of the scene based on both tracking data and 3D point clouds.
    # The resulting output can be a \ref Mesh or a \ref FusedPointCloud. It can be be obtained by calling \ref extract_whole_spatial_map() or \ref retrieve_spatial_map_async().
    # Note that \ref retrieve_spatial_map_async should be called after \ref request_spatial_map_async().
    # 
    # \param py_spatial : the structure containing all the specific parameters for the spatial mapping.
    # Default: a balanced parameter preset between geometric fidelity and output file size. For more information, see the \ref SpatialMappingParameters documentation.
    # \return \ref ERROR_CODE.SUCCESS if everything went fine, \ref ERROR_CODE "ERROR_CODE.FAILURE" otherwise.
    #
    # \warning The tracking (\ref enable_positional_tracking() ) and the depth (\ref RuntimeParameters.enable_depth ) needs to be enabled to use the spatial mapping.
    # \warning The performance greatly depends on the spatial_mapping_parameters.
    # \ Lower SpatialMappingParameters.range_meter and SpatialMappingParameters.resolution_meter for higher performance.
    # If the mapping framerate is too slow in live mode, consider using an SVO file, or choose a lower mesh resolution.
    #
    # \note This features uses host memory (RAM) to store the 3D map. The maximum amount of available memory allowed can be tweaked using the SpatialMappingParameters.
    # Exeeding the maximum memory allowed immediately stops the mapping.
    #
    # \code
    # import pyzed.sl as sl
    # def main() :
    #     # Create a ZED camera object
    #     zed = sl.Camera()
    #
    #     # Set initial parameters
    #     init_params = sl.InitParameters()
    #     init_params.camera_resolution = sl.RESOLUTION.HD720 # Use HD720 video mode (default fps: 60)
    #     init_params.coordinate_system = sl.COORDINATE_SYSTEM.RIGHT_HANDED_Y_UP # Use a right-handed Y-up coordinate system (The OpenGL one)
    #     init_params.coordinate_units = sl.UNIT.METER # Set units in meters
    #
    #     # Open the camera
    #     err = zed.open(init_params)
    #     if err != sl.ERROR_CODE.SUCCESS :
    #         exit(-1)
    #
    #     # Positional tracking needs to be enabled before using spatial mapping
    #     tracking_parameters sl.PositionalTrackingParameters()
    #     err = zed.enable_tracking(tracking_parameters)
    #     if err != sl.ERROR_CODE.SUCCESS :
    #         exit(-1)
    #
    #     # Enable spatial mapping
    #     mapping_parameters sl.SpatialMappingParameters()
    #     err = zed.enable_spatial_mapping(mapping_parameters)
    #     if err != sl.ERROR_CODE.SUCCESS :
    #         exit(-1)
    #
    #     # Grab data during 500 frames
    #     i = 0
    #     mesh = sl.Mesh() # Create a mesh object
    #     while i < 500 :
    #     # For each new grab, mesh data is updated
    #     if zed.grab() == sl.ERROR_CODE.SUCCESS :
    #         # In the background, spatial mapping will use newly retrieved images, depth and pose to update the mesh
    #         mapping_state = zed.get_spatial_mapping_state()
    #
    #         # Print spatial mapping state
    #         print("Images captured: ", i << " / 500  ||  Spatial mapping state: ", repr(mapping_state))
    #         i = i + 1
    #
    #     # Extract, filter and save the mesh in a obj file
    #     print("Extracting Mesh ...")
    #     zed.extract_whole_spatial_map(mesh) # Extract the whole mesh
    #     print("Filtering Mesh ...")
    #     mesh.filter(sl.MESH_FILTER.LOW) # Filter the mesh (remove unnecessary vertices and faces)
    #     print("Saving Mesh in mesh.obj ...")
    #     mesh.save("mesh.obj") # Save the mesh in an obj file
    #
    #     # Disable tracking and mapping and close the camera
    #     zed.disable_spatial_mapping()
    #     zed.disable_tracking()
    #     zed.close()
    #     return 0
    #
    # if __name__ == "__main__" :
    #     main()
    # \endcode
    def enable_spatial_mapping(self, SpatialMappingParameters py_spatial=SpatialMappingParameters()):
        if py_spatial:
            return ERROR_CODE(<int>self.camera.enableSpatialMapping(deref(py_spatial.spatial)))
        else:
            print("SpatialMappingParameters must be initialized first with SpatialMappingParameters()")

    ##
    # Pauses or resumes the spatial mapping processes.
    # 
    # As spatial mapping runs asynchronously, using this function can pause its computation to free some processing power, and resume it again later.
    # For example, it can be used to avoid mapping a specific area or to pause the mapping when the camera is static.
    # \param status : if true, the integration is paused. If false, the spatial mapping is resumed.
    def pause_spatial_mapping(self, status):
        if isinstance(status, bool):
            self.camera.pauseSpatialMapping(status)
        else:
            raise TypeError("Argument is not of boolean type.")

    ##
    # Returns the current spatial mapping state.
    #
    # As the spatial mapping runs asynchronously, this function allows you to get reported errors or status info.
    # \return The current state of the spatial mapping process
    # 
    # See also \ref SPATIAL_MAPPING_STATE
    def get_spatial_mapping_state(self):
        return SPATIAL_MAPPING_STATE(<int>self.camera.getSpatialMappingState())

    ##
    # Starts the spatial map generation process in a non blocking thread from the spatial mapping process.
    # 
    # The spatial map generation can take a long time depending on the mapping resolution and covered area. This function will trigger the generation of a mesh without blocking the program.
    # You can get info about the current generation using \ref get_spatial_map_request_status_async(), and retrieve the mesh using \ref retrieve_spatial_map_async().
    #
    # \note Only one mesh can be generated at a time. If the previous mesh generation is not over, new calls of the function will be ignored.
    # 
    #
    # \code
    # cam.request_spatial_map_async()
    # while cam.get_spatial_map_request_status_async() == sl.ERROR_CODE.FAILURE :
    #     # Mesh is generating
    #
    # mesh = sl.Mesh()
    # if cam.get_spatial_map_request_status_async() == sl.ERROR_CODE.SUCCESS :
    #     cam.retrieve_spatial_map_async(mesh)
    #     nb_triangles = mesh.get_number_of_triangles()
    #     print("Number of triangles in the mesh: ", mesh)
    # \endcode
    def request_spatial_map_async(self):
        self.camera.requestSpatialMapAsync()

    ##
    # Returns the spatial map generation status. This status allows to know if the mesh can be retrieved by calling \ref retrieve_spatial_map_async()
    # \return \ref ERROR_CODE.SUCCESS if the mesh is ready and not yet retrieved, otherwise \ref ERROR_CODE.FAILURE
    def get_spatial_map_request_status_async(self):
        return ERROR_CODE(<int>self.camera.getSpatialMapRequestStatusAsync())

    ##
    # Retrieves the current generated spatial map.
    # 
    # After calling \ref retrieve_spatial_map_async() , this function allows you to retrieve the generated mesh or fused point cloud. The \ref Mesh or \ref FusedPointCloud will only be available when \ref get_spatial_map_request_status_async() returns \ref ERROR_CODE.SUCCESS
    #
    # \param py_mesh : \b [out] The \ref Mesh or \ref FusedPointCloud to be filled with the generated spatial map.
    # \return \ref ERROR_CODE.SUCCESS if the mesh is retrieved, otherwise
    # 
    # \note This function only updates the necessary chunks and adds the new ones in order to improve update speed.
    # \warning You should not modify the mesh / fused point cloud between two calls of this function, otherwise it can lead to corrupted mesh / fused point cloud .
    #
    # See \ref request_spatial_map_async() for an example.
    def retrieve_spatial_map_async(self, py_mesh):
        if isinstance(py_mesh, Mesh) :
            return ERROR_CODE(<int>self.camera.retrieveSpatialMapAsync(deref((<Mesh>py_mesh).mesh)))
        elif isinstance(py_mesh, FusedPointCloud) :
            py_mesh = <FusedPointCloud> py_mesh
            return ERROR_CODE(<int>self.camera.retrieveSpatialMapAsync(deref((<FusedPointCloud>py_mesh).fpc)))
        else :
           raise TypeError("Argument is not of Mesh or FusedPointCloud type.") 

    ##
    # Extracts the current spatial map from the spatial mapping process.
    #
    # If the object to be filled already contains a previous version of the mesh / fused point cloud, only changes will be updated, optimizing performance.
    #
    # \param py_mesh : \b [out] The \ref Mesh or \ref FuesedPointCloud to be filled with the generated spatial map.
    #
    # \return \ref ERROR_CODE.SUCCESS if the mesh is filled and available, otherwise \ref ERROR_CODE.FAILURE
    #
    # \warning This is a blocking function. You should either call it in a thread or at the end of the mapping process.
    # The extraction can be long, calling this function in the grab loop will block the depth and tracking computation giving bad results.
    def extract_whole_spatial_map(self, py_mesh):
        if isinstance(py_mesh, Mesh) :
            return ERROR_CODE(<int>self.camera.extractWholeSpatialMap(deref((<Mesh>py_mesh).mesh)))
        elif isinstance(py_mesh, FusedPointCloud) :
            return ERROR_CODE(<int>self.camera.extractWholeSpatialMap(deref((<FusedPointCloud>py_mesh).fpc)))
        else :
           raise TypeError("Argument is not of Mesh or FusedPointCloud type.") 

    ##
    # Checks the plane at the given left image coordinates.
    # 
    # This function gives the 3D plane corresponding to a given pixel in the latest left image \ref grab() "grabbed".
    # The pixel coordinates are expected to be contained between 0 and \ref CameraInformations.camera_resolution "get_camera_informations().camera_resolution.width-1" and  \ref CameraInformations.camera_resolution "get_camera_informations().camera_resolution.height-1"
    # 
    # \param coord :  \b [in] The image coordinate. The coordinate must be taken from the full-size image
    # \param plane : \b [out] The detected plane if the function succeeded
    # \return \ref ERROR_CODE.SUCCESS if a plane is found otherwise \ref ERROR_CODE.PLANE_NOT_FOUND 
    #
    # \note The reference frame is defined by the \ref RuntimeParameters.measure3D_reference_frame given to the \ref grab() function.
    def find_plane_at_hit(self, coord, Plane py_plane):
        cdef Vector2[uint] vec = Vector2[uint](coord[0], coord[1])
        return ERROR_CODE(<int>self.camera.findPlaneAtHit(vec, py_plane.plane))

    ##
    # Detect the floor plane of the scene.
    # 
    # This function analyses the latest image and depth to estimate the floor plane of the scene.
    # 
    # It expects the floor plane to be visible and bigger than other candidate planes, like a table.
    # 
    # \param py_plane : \b [out] The detected floor plane if the function succeeded
    # \param resetTrackingFloorFrame : \b [out] The transform to align the tracking with the floor plane. The initial position will then be at ground height, with the axis align with the gravity. The positional tracking needs to be reset/enabled
    # \param floor_height_prior : \b [in] Prior set to locate the floor plane depending on the known camera distance to the ground, expressed in the same unit as the ZED. If the prior is too far from the detected floor plane, the function will return \ref ERROR_CODE.PLANE_NOT_FOUND
    # \param world_orientation_prior : \b [in] Prior set to locate the floor plane depending on the known camera  orientation to the ground. If the prior is too far from the detected floor plane, the function will return \ref ERROR_CODE.PLANE_NOT_FOUND
    # \param floor_height_prior_tolerance : \b [in] Prior height tolerance, absolute value.
    # \return \ref ERROR_CODE.SUCCESS if the floor plane is found and matches the priors (if defined), otherwise \ref ERROR_CODE.PLANE_NOT_FOUND
    #
    # \note The reference frame is defined by the \ref RuntimeParameters (measure3D_reference_frame) given to the \ref grab() function. The length unit is defined by \ref InitParameters (coordinate_units). With the ZED, the assumption is made that the floor plane is the dominant plane in the scene. The ZED Mini uses the gravity as prior.
    #
    def find_floor_plane(self, Plane py_plane, Transform resetTrackingFloorFrame, floor_height_prior = float('nan'), Rotation world_orientation_prior = Rotation(Matrix3f().zeros()), floor_height_prior_tolerance = float('nan')) :
        return ERROR_CODE(<int>self.camera.findFloorPlane(py_plane.plane, resetTrackingFloorFrame.transform, floor_height_prior, world_orientation_prior.rotation, floor_height_prior_tolerance))

    ##
    # Disables the spatial mapping process.
    # The spatial mapping is immediately stopped.
    # If the mapping has been enabled, this function will automatically be called by \ref close() .
    # \note This function frees the memory allocated for th spatial mapping, consequently, mesh cannot be retrieved after this call.
    def disable_spatial_mapping(self):
        self.camera.disableSpatialMapping()


    ##
    # Creates a streaming pipeline for images.
    # \param streaming_parameters : the structure containing all the specific parameters for the streaming.
    #
    # \code
    # import pyzed.sl as sl
    #
    # def main() :
    #     # Create a ZED camera object
    #     zed = sl.Camera()
    #
    #     # Set initial parameters
    #     init_params = sl.InitParameters()
    #     init_params.camera_resolution = sl.RESOLUTION.HD720 # Use HD720 video mode (default fps: 60)
    #
    #     # Open the camera
    #     err = zed.open(init_params)
    #     if err != sl.ERROR_CODE.SUCCESS :
    #        print(repr(err))
    #        exit(-1)
    #
    #     # Enable streaming
    #     stream_params = sl.StreamingParameters()
    #     stream_params.port = 30000
    #     stream_params.bitrate = 8000
    #     err = zed.enable_streaming(stream_params)
    #     if err != sl.ERROR_CODE.SUCCESS :
    #         print(repr(err))
    #         exit(-1)
    #
    #     # Grab data during 500 frames
    #     i = 0
    #     while i < 500 :
    #         if zed.grab() == sl.ERROR_CODE.SUCCESS :
    #             i = i+1
    #
    #     zed.disable_streaming()
    #     zed.close()
    #     return 0
    #
    # if __name__ == "__main__" :
    #     main()  
    # \endcode
    #
    # \return an \ref ERROR_CODE that defines if the stream was started.
    # \n Possible Error Code :
    # \n - \ref ERROR_CODE.SUCCESS if the streaming was successfully started
    # \n - \ref ERROR_CODE.INVALID_FUNCTION_CALL if open() was not successfully called before.
    # \n - \ref ERROR_CODE.FAILURE if streaming RTSP protocol was not able to start.
    # \n - \ref ERROR_CODE.NO_GPU_COMPATIBLE if streaming codec is not supported (in this case, use H264 codec).
    def enable_streaming(self, StreamingParameters streaming_parameters = StreamingParameters()) :
        return ERROR_CODE(<int>self.camera.enableStreaming(deref(streaming_parameters.streaming)))

    ##
    # Disables the streaming initiated by \ref enable_straming()
    # \note This function will automatically be called by \ref close() if enable_streaming() was called.
    #
    # See \ref enable_streaming() for an example.
    def disable_streaming(self):
        self.camera.disableStreaming()

    ##
    # Tells if the streaming is actually sending data (true) or still in configuration (false)
    def is_streaming_enabled(self):
        return self.camera.isStreamingEnabled()


    ##
    # Creates an SVO file to be filled by \ref record().
    # 
    # SVO files are custom video files containing the un-rectified images from the camera along with some meta-data like timestamps or IMU orientation (if applicable).
    # They can be used to simulate a live ZED and test a sequence with various SDK parameters.
    # Depending on the application, various compression modes are available. See \ref SVO_COMPRESSION_MODE.
    # 
    # \param record : \ref RecordingParameters such as filename and compression mode
    # 
    # \return an \ref ERROR_CODE that defines if SVO file was successfully created and can be filled with images.
    # 
    # \warning This function can be called multiple times during ZED lifetime, but if video_filename is already existing, the file will be erased.
    #
    # 
    # \code
    # import pyzed.sl as sl
    # def main() :
    #     # Create a ZED camera object
    #     zed = sl.Camera()
    #     # Set initial parameters
    #     init_params = sl.InitParameters()
    #     init_params.camera_resolution = sl.RESOLUTION.HD720 # Use HD720 video mode (default fps: 60)
    #     init_params.coordinate_units = sl.UNIT.METER # Set units in meters
    #     # Open the camera
    #     err = zed.open(init_params)
    #     if (err != sl.ERROR_CODE.SUCCESS) :
    #         print(repr(err))
    #         exit(-1)
    #
    #     # Enable video recording
    #     record_params = RecordingParameters("myVideoFile.svo, sl.SVO_COMPRESSION_MODE.HD264)
    #     err = zed.enable_recording(record_params)
    #     if (err != sl.ERROR_CODE.SUCCESS) :
    #         print(repr(err))
    #         exit(-1)
    # 
    #     # Grab data during 500 frames
    #     i = 0
    #     while i < 500 :
    #         # Grab a new frame
    #         if zed.grab() == sl.ERROR_CODE.SUCCESS :
    #             # Record the grabbed frame in the video file
    #             i = i + 1
    # 
    #     zed.disable_recording()
    #     print("Video has been saved ...")
    #     zed.close()
    #     return 0
    #
    # if __name__ == "__main__" :
    #     main()
    # \endcode
    def enable_recording(self, RecordingParameters record):
        if isinstance(record, RecordingParameters):
            return ERROR_CODE(<int>self.camera.enableRecording(deref(record.record)))
        else:
            raise TypeError("Argument is not of RecordingParameters type.")

    ##
    # Disables the recording initiated by \ref enable_recording() and closes the generated file.
    #
    # \note This function will automatically be called by \ref close() if \ref enable_recording() was called.
    # 
    # See \ref enable_recording() for an example.
    def disable_recording(self):
        self.camera.disableRecording()

    ##
    # Get the recording information
    # \return The recording state structure. For more details, see \ref RecordingStatus.
    def get_recording_status(self):
        state = RecordingStatus()
        state.recordingStatus = self.camera.getRecordingStatus();
        return state

    ##
    # Pauses or resumes the recording.
    # \param status : if true, the recording is paused. If false, the recording is resumed.
    def pause_recording(self, bool value=True):
        self.camera.pauseRecording(value)

    ##
    # Returns the recording parameters used. Correspond to the structure send when the \ref enable_recording() function was called
    #
    # \return \ref RecordingParameters containing the parameters used for streaming initialization.
    def get_recording_parameters(self):
        param = RecordingParameters()
        param.record.video_filename = self.camera.getRecordingParameters().video_filename
        param.record.compression_mode = self.camera.getRecordingParameters().compression_mode
        return param

    ##
    # Initializes and starts the object detection module.
    # 
    # The object detection module will detect and track objects, peoples or animals in range of the camera, the full list of detectable objects is available in \ref OBJECT_CLASS.
    # 
    # Detected objects can be retrieved using the \ref retrieve_objects() function.
    #
    # As detecting and tracking the objects is CPU and GPU-intensive, the module can be used synchronously or asynchronously using \ref ObjectDetectionParameters.image_sync .
    # - <b>Synchronous:</b> the \ref retrieve_objects() function will be blocking during the detection.
    # - <b>Asynchronous:</b> the detection is running in the background, and \ref retrieve_objects() will immediately return the last objects detected.
    # 
    # \param object_detection_parameters : Structure containing all specific parameters for object detection.
    # 
    # For more information, see the \ref ObjectDetectionParameters documentation
    # \return
    # \ref ERROR_CODE.SUCCESS if everything went fine
    # \ref ERROR_CODE.OBJECT_DETECTION_NOT_AVAILABLE if the AI model is missing or corrupted. In this case, the SDK needs to be reinstalled
    # \ref ERROR_CODE.OBJECT_DETECTION_MODULE_NOT_COMPATIBLE_WITH_CAMERA f the camera used does not have a IMU (ZED Camera). the IMU gives the gravity vector that helps in the 3D box localization. Therefore the Object detection module is available only for ZED-M and ZED2 camera model.
    # \ref ERROR_CODE.SENSORS_NOT_DETECTED if the camera model is correct (ZED-M or ZED2) but the IMU is missing. It probably happens because \ref InitParameters.sensors_required was set to true
    # \ref ERROR_CODE.INVALID_FUNCTION_CALL if one of the  \ref ObjectDetection parameter is not compatible with other modules parameters (For example, depth mode has been set to NONE).
    # \ref ERROR_CODE.FAILURE otherwise.
    #
    # \note This feature uses AI to locate objects and requires a powerful GPU. A GPU with at least 3GB of memory is recommended.
    #
    # \code
    # import pyzed.sl as sl
    #
    # def main():
    #     # Create a ZED camera object
    #     zed = sl.Camera()
    # 
    #     # Open the camera
    #     err = zed.open()
    #     if err != sl.ERROR_CODE.SUCCESS :
    #         print(repr(err))
    #         exit(-1)
    #
    #     # Set the object detection parameters
    #     object_detection_params = sl.ObjectDetectionParameters()
    #     object_detection_params.image_sync = True
    #
    #     # Enable the object detection
    #     err = zed.enable_object_detection(object_detection_params)
    #     if err != sl.ERROR_CODE.SUCCESS :
    #         print(repr(err))
    #         exit(-1)
    #
    #     # Grab an image and detect objects on it
    #     objects = sl.Objects()
    #     while True :
    #         if zed.grab() == sl.ERROR_CODE.SUCCESS :
    #             zed.retrieve_objects(objects)
    #             print(len(objects.object_list), " objects detected\n")
    #             # Use the objects in your application
    # 
    #     # Close the camera
    #     zed.disable_object_detection()
    #     zed.close()
    #
    # if __name__ == "__main__":
    #     main()
    # \endcode
    def enable_object_detection(self, ObjectDetectionParameters object_detection_parameters = ObjectDetectionParameters()) :
        return ERROR_CODE(<int>self.camera.enableObjectDetection(deref(object_detection_parameters.object_detection)))


    ##
    # Disables the Object Detection process.
    #
    # The object detection module immediately stops and frees its memory allocations.
    # If the object detection has been enabled, this function will automatically be called by \ref close().
    def disable_object_detection(self):
        self.camera.disableObjectDetection()

    ##
    # Pauses or resumes the object detection processes.
    #
    # If the object detection has been enabled with  \ref ObjectDetectionParameters.image_sync set to false (running asynchronously), this function will pause processing.
    # While in pause, calling this function with <i>status = false</i> will resume the object detection.
    # The \ref retrieve_objects function will keep on returning the last objects detected while in pause.
    #
    # \param status : If true, object detection is paused. If false, object detection is resumed.
    def pause_object_detection(self, status):
        if isinstance(status, bool):
            self.camera.pauseObjectDetection(status)
        else:
            raise TypeError("Argument is not of boolean type.")


    ##
    # Retrieve objects detected by the object detection module.
    #
    # This function returns the result of the object detection, whether the module is running synchronously or asynchronously.
    #
    # - <b>Asynchronous:</b> this function immediately returns the last objects detected. If the current detection isn't done, the objects from the last detection will be returned, and \ref Objects::is_new will be set to false.
    # - <b>Synchronous:</b> this function executes detection and waits for it to finish before returning the detected objects.
    #
    # It is recommended to keep the same \ref Objects object as the input of all calls to this function. This will enable the identification and the tracking of every objects detected.
    # 
    # \param py_objects : [in,out] The detected objects will be saved into this object. If the object already contains data from a previous detection, it will be updated, keeping a unique ID for the same person.
    # \param object_detection_parameters : [in] Object detection runtime settings, can be changed at each detection. In async mode, the parameters update is applied on the next iteration.
    # \return \ref ERROR_CODE.SUCCESS if everything went fine, \ref ERROR_CODE.FAILURE otherwise
    #
    # \code
    # objects = sl.Objects()
    # while True :
    #     if zed.grab() == sl.ERROR_CODE.SUCCESS :
    #         zed.retrieve_objects(objects)
    #         object_list = objects.object_list
    #         for i in range(len(object_list)) :
    #             print(repr(object_list[i].label))
    # \endcode
    def retrieve_objects(self, py_objects, ObjectDetectionRuntimeParameters object_detection_parameters=ObjectDetectionRuntimeParameters()):
        if isinstance(py_objects, Objects) :
            return ERROR_CODE(<int>self.camera.retrieveObjects((<Objects>py_objects).objects, deref(object_detection_parameters.object_detection_rt)))
        else :
           raise TypeError("Argument is not of Objects type.") 


    ##
    # Returns the version of the currently installed ZED SDK.
    @staticmethod
    def get_sdk_version():
        cls = Camera()
        return cls.camera.getSDKVersion().get().decode()

    ##
    # List all the connected devices with their associated information.
    # This function lists all the cameras available and provides their serial number, models and other information.
    # \return The device properties for each connected camera
    @staticmethod
    def get_device_list():
        cls = Camera()
        vect_ = cls.camera.getDeviceList()
        vect_python = []
        for i in range(vect_.size()):
            prop = DeviceProperties()
            prop.camera_state = <int> vect_[i].camera_state
            prop.id = vect_[i].id
            prop.path = vect_[i].path.get().decode()
            prop.camera_model = MODEL(<int>vect_[i].camera_model)
            prop.serial_number = vect_[i].serial_number
            vect_python.append(prop)
        return vect_python

    ##
    # List all the streaming devices with their associated information.
    # 
    # \return The streaming properties for each connected camera
    #
    # \warning As this function returns an std::vector, it is only safe to use in Release mode (not Debug).
    # This is due to a known compatibility issue between release (the SDK) and debug (your app) implementations of std::vector.
    @staticmethod
    def get_streaming_device_list():
        cls = Camera()
        vect_ = cls.camera.getStreamingDeviceList()
        vect_python = []
        for i in range(vect_.size()):
            prop = StreamingProperties()
            prop.ip = to_str(vect_[i].ip)
            prop.port = vect_[i].port
            prop.serial_number = vect_[i].serial_number
            prop.current_bitrate = vect_[i].current_bitrate
            prop.codec = STREAMING_CODEC(<int>vect_[i].codec)
            vect_python.append(prop)
        return vect_python

    ##
    # Performs an hardware reset of the ZED 2.
    # 
    # \param Serial number of the camera to reset, or 0 to reset the first camera detected.
    # \return \ref ERROR_CODE.SUCCESS if everything went fine, \ref ERROR_CODE.CAMERA_NOT_DETECTED if no camera was detected, \ref ERROR_CODE.FAILURE  otherwise.
    #
    # \note This function only works for ZED 2 cameras.
    # 
    # \warning This function will invalidate any sl.Camera object, since the device is rebooting.
    @staticmethod
    def reboot(int sn):
        cls = Camera()
        return ERROR_CODE(<int>cls.camera.reboot(sn))

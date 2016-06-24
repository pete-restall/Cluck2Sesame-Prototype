#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif

# Environment
MKDIR=mkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=cof
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/Cluck2Sesame.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/Cluck2Sesame.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/_ext/1472/BrownOutReset.o ${OBJECTDIR}/_ext/1472/PowerOnReset.o ${OBJECTDIR}/_ext/1472/Main.o ${OBJECTDIR}/_ext/1472/Isr.o ${OBJECTDIR}/_ext/1472/Cluck2Sesame.o
POSSIBLE_DEPFILES=${OBJECTDIR}/_ext/1472/BrownOutReset.o.d ${OBJECTDIR}/_ext/1472/PowerOnReset.o.d ${OBJECTDIR}/_ext/1472/Main.o.d ${OBJECTDIR}/_ext/1472/Isr.o.d ${OBJECTDIR}/_ext/1472/Cluck2Sesame.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/1472/BrownOutReset.o ${OBJECTDIR}/_ext/1472/PowerOnReset.o ${OBJECTDIR}/_ext/1472/Main.o ${OBJECTDIR}/_ext/1472/Isr.o ${OBJECTDIR}/_ext/1472/Cluck2Sesame.o


CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/Cluck2Sesame.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=16f685
MP_LINKER_DEBUG_OPTION= -u_DEBUGCODESTART=0xf00 -u_DEBUGCODELEN=0xff -u_DEBUGDATASTART=0x165 -u_DEBUGDATALEN=0xb
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/1472/BrownOutReset.o: ../BrownOutReset.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1472 
	@${RM} ${OBJECTDIR}/_ext/1472/BrownOutReset.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/_ext/1472/BrownOutReset.err" $(SILENT) -rsi ${MP_CC_DIR}  -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PK3=1 -q -p$(MP_PROCESSOR_OPTION) -u  -l\"${OBJECTDIR}/_ext/1472/BrownOutReset.lst\" -e\"${OBJECTDIR}/_ext/1472/BrownOutReset.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/_ext/1472/BrownOutReset.o\" ../BrownOutReset.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/_ext/1472/BrownOutReset.o 
	
${OBJECTDIR}/_ext/1472/PowerOnReset.o: ../PowerOnReset.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1472 
	@${RM} ${OBJECTDIR}/_ext/1472/PowerOnReset.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/_ext/1472/PowerOnReset.err" $(SILENT) -rsi ${MP_CC_DIR}  -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PK3=1 -q -p$(MP_PROCESSOR_OPTION) -u  -l\"${OBJECTDIR}/_ext/1472/PowerOnReset.lst\" -e\"${OBJECTDIR}/_ext/1472/PowerOnReset.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/_ext/1472/PowerOnReset.o\" ../PowerOnReset.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/_ext/1472/PowerOnReset.o 
	
${OBJECTDIR}/_ext/1472/Main.o: ../Main.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1472 
	@${RM} ${OBJECTDIR}/_ext/1472/Main.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/_ext/1472/Main.err" $(SILENT) -rsi ${MP_CC_DIR}  -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PK3=1 -q -p$(MP_PROCESSOR_OPTION) -u  -l\"${OBJECTDIR}/_ext/1472/Main.lst\" -e\"${OBJECTDIR}/_ext/1472/Main.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/_ext/1472/Main.o\" ../Main.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/_ext/1472/Main.o 
	
${OBJECTDIR}/_ext/1472/Isr.o: ../Isr.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1472 
	@${RM} ${OBJECTDIR}/_ext/1472/Isr.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/_ext/1472/Isr.err" $(SILENT) -rsi ${MP_CC_DIR}  -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PK3=1 -q -p$(MP_PROCESSOR_OPTION) -u  -l\"${OBJECTDIR}/_ext/1472/Isr.lst\" -e\"${OBJECTDIR}/_ext/1472/Isr.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/_ext/1472/Isr.o\" ../Isr.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/_ext/1472/Isr.o 
	
${OBJECTDIR}/_ext/1472/Cluck2Sesame.o: ../Cluck2Sesame.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1472 
	@${RM} ${OBJECTDIR}/_ext/1472/Cluck2Sesame.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/_ext/1472/Cluck2Sesame.err" $(SILENT) -rsi ${MP_CC_DIR}  -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PK3=1 -q -p$(MP_PROCESSOR_OPTION) -u  -l\"${OBJECTDIR}/_ext/1472/Cluck2Sesame.lst\" -e\"${OBJECTDIR}/_ext/1472/Cluck2Sesame.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/_ext/1472/Cluck2Sesame.o\" ../Cluck2Sesame.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/_ext/1472/Cluck2Sesame.o 
	
else
${OBJECTDIR}/_ext/1472/BrownOutReset.o: ../BrownOutReset.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1472 
	@${RM} ${OBJECTDIR}/_ext/1472/BrownOutReset.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/_ext/1472/BrownOutReset.err" $(SILENT) -rsi ${MP_CC_DIR}  -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION) -u  -l\"${OBJECTDIR}/_ext/1472/BrownOutReset.lst\" -e\"${OBJECTDIR}/_ext/1472/BrownOutReset.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/_ext/1472/BrownOutReset.o\" ../BrownOutReset.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/_ext/1472/BrownOutReset.o 
	
${OBJECTDIR}/_ext/1472/PowerOnReset.o: ../PowerOnReset.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1472 
	@${RM} ${OBJECTDIR}/_ext/1472/PowerOnReset.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/_ext/1472/PowerOnReset.err" $(SILENT) -rsi ${MP_CC_DIR}  -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION) -u  -l\"${OBJECTDIR}/_ext/1472/PowerOnReset.lst\" -e\"${OBJECTDIR}/_ext/1472/PowerOnReset.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/_ext/1472/PowerOnReset.o\" ../PowerOnReset.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/_ext/1472/PowerOnReset.o 
	
${OBJECTDIR}/_ext/1472/Main.o: ../Main.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1472 
	@${RM} ${OBJECTDIR}/_ext/1472/Main.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/_ext/1472/Main.err" $(SILENT) -rsi ${MP_CC_DIR}  -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION) -u  -l\"${OBJECTDIR}/_ext/1472/Main.lst\" -e\"${OBJECTDIR}/_ext/1472/Main.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/_ext/1472/Main.o\" ../Main.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/_ext/1472/Main.o 
	
${OBJECTDIR}/_ext/1472/Isr.o: ../Isr.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1472 
	@${RM} ${OBJECTDIR}/_ext/1472/Isr.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/_ext/1472/Isr.err" $(SILENT) -rsi ${MP_CC_DIR}  -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION) -u  -l\"${OBJECTDIR}/_ext/1472/Isr.lst\" -e\"${OBJECTDIR}/_ext/1472/Isr.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/_ext/1472/Isr.o\" ../Isr.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/_ext/1472/Isr.o 
	
${OBJECTDIR}/_ext/1472/Cluck2Sesame.o: ../Cluck2Sesame.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1472 
	@${RM} ${OBJECTDIR}/_ext/1472/Cluck2Sesame.o.d 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/_ext/1472/Cluck2Sesame.err" $(SILENT) -rsi ${MP_CC_DIR}  -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION) -u  -l\"${OBJECTDIR}/_ext/1472/Cluck2Sesame.lst\" -e\"${OBJECTDIR}/_ext/1472/Cluck2Sesame.err\" $(ASM_OPTIONS)   -o\"${OBJECTDIR}/_ext/1472/Cluck2Sesame.o\" ../Cluck2Sesame.asm 
	@${DEP_GEN} -d ${OBJECTDIR}/_ext/1472/Cluck2Sesame.o 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/Cluck2Sesame.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD} $(MP_EXTRA_LD_PRE) "../Cluck2Sesame.lkr"  -p$(MP_PROCESSOR_OPTION)  -w -x -u_DEBUG -z__ICD2RAM=1 -m"Cluck2Sesame.map"   -z__MPLAB_BUILD=1  -z__MPLAB_DEBUG=1 -z__MPLAB_DEBUGGER_PK3=1 $(MP_LINKER_DEBUG_OPTION) -odist/${CND_CONF}/${IMAGE_TYPE}/Cluck2Sesame.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  ${OBJECTFILES}     
else
dist/${CND_CONF}/${IMAGE_TYPE}/Cluck2Sesame.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD} $(MP_EXTRA_LD_PRE) "../Cluck2Sesame.lkr"  -p$(MP_PROCESSOR_OPTION)  -w  -m"Cluck2Sesame.map"   -z__MPLAB_BUILD=1  -odist/${CND_CONF}/${IMAGE_TYPE}/Cluck2Sesame.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES}     
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/default
	${RM} -r dist/default

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell "${PATH_TO_IDE_BIN}"mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif

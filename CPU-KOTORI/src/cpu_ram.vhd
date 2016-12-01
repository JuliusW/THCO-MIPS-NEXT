----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:13:43 11/29/2016 
-- Design Name: 
-- Module Name:    cpu_ram - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
library WORK;
use WORK.util.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cpu_ram is

port(
    addr_i : in Bus16;
    ram1_data_io : inout Bus16;
    ram2_data_io : inout Bus16;
    
    --读写内存 <==> ram2
    --读写串口 <==> ram1
    
    ram2_r_en_i, ram2_w_en_i : in std_logic;
    com_r_en_i, com_w_en_i : in std_logic);

end cpu_ram;

architecture Behavioral of cpu_ram is

type memory is array(IEEE.STD_LOGIC_UNSIGNED.CONV_INTEGER("00" & x"0000") to IEEE.STD_LOGIC_UNSIGNED.CONV_INTEGER("00" & x"FFFF")) of Bus16;

signal my_ram : memory := (
    -- 0 => x"0000",
    -- 1 => x"0000",
    -- 2 => x"0800",
    -- 3 => x"1044",
    -- 4 => x"0800",
    -- 5 => x"0800",
    -- 6 => x"0800",
    -- 7 => x"0800",
    -- 8 => x"6EBF",
    -- 9 => x"36C0",
    -- 10 => x"4E10",
    -- 11 => x"DE00",
    -- 12 => x"DE21",
    -- 13 => x"DE42",
    -- 14 => x"9100",
    -- 15 => x"6301",
    -- 16 => x"68FF",
    -- 17 => x"E90C",
    -- 18 => x"9200",
    -- 19 => x"6301",
    -- 20 => x"63FF",
    -- 21 => x"D300",
    -- 22 => x"63FF",
    -- 23 => x"D700",
    -- 24 => x"6B0F",
    -- 25 => x"EF40",
    -- 26 => x"4F03",
    -- 27 => x"0800",
    -- 28 => x"108A",
    -- 29 => x"0800",
    -- 30 => x"6EBF",
    -- 31 => x"36C0",
    -- 32 => x"DE60",
    -- 33 => x"0800",
    -- 34 => x"EF40",
    -- 35 => x"4F03",
    -- 36 => x"0800",
    -- 37 => x"1081",
    -- 38 => x"0800",
    -- 39 => x"6EBF",
    -- 40 => x"36C0",
    -- 41 => x"DE20",
    -- 42 => x"0800",
    -- 43 => x"6B0F",
    -- 44 => x"EF40",
    -- 45 => x"4F03",
    -- 46 => x"0800",
    -- 47 => x"1077",
    -- 48 => x"0800",
    -- 49 => x"6EBF",
    -- 50 => x"36C0",
    -- 51 => x"DE60",
    -- 52 => x"0800",
    -- 53 => x"42C0",
    -- 54 => x"F300",
    -- 55 => x"6880",
    -- 56 => x"3000",
    -- 57 => x"EB0D",
    -- 58 => x"6FBF",
    -- 59 => x"37E0",
    -- 60 => x"4F10",
    -- 61 => x"9F00",
    -- 62 => x"9F21",
    -- 63 => x"9F42",
    -- 64 => x"9700",
    -- 65 => x"6301",
    -- 66 => x"6301",
    -- 67 => x"0800",
    -- 68 => x"F301",
    -- 69 => x"EE00",
    -- 70 => x"93FF",
    -- 71 => x"0800",
    -- 72 => x"6807",
    -- 73 => x"F001",
    -- 74 => x"68BF",
    -- 75 => x"3000",
    -- 76 => x"4810",
    -- 77 => x"6400",
    -- 78 => x"0800",
    -- 79 => x"6EBF",
    -- 80 => x"36C0",
    -- 81 => x"4E10",
    -- 82 => x"6800",
    -- 83 => x"DE00",
    -- 84 => x"DE01",
    -- 85 => x"DE02",
    -- 86 => x"DE03",
    -- 87 => x"DE04",
    -- 88 => x"DE05",
    -- 89 => x"EF40",
    -- 90 => x"4F03",
    -- 91 => x"0800",
    -- 92 => x"104A",
    -- 93 => x"6EBF",
    -- 94 => x"36C0",
    -- 95 => x"684F",
    -- 96 => x"DE00",
    -- 97 => x"0800",
    -- 98 => x"EF40",
    -- 99 => x"4F03",
    -- 100 => x"0800",
    -- 101 => x"1041",
    -- 102 => x"6EBF",
    -- 103 => x"36C0",
    -- 104 => x"684B",
    -- 105 => x"DE00",
    -- 106 => x"0800",
    -- 107 => x"EF40",
    -- 108 => x"4F03",
    -- 109 => x"0800",
    -- 110 => x"1038",
    -- 111 => x"6EBF",
    -- 112 => x"36C0",
    -- 113 => x"680A",
    -- 114 => x"DE00",
    -- 115 => x"0800",
    -- 116 => x"EF40",
    -- 117 => x"4F03",
    -- 118 => x"0800",
    -- 119 => x"102F",
    -- 120 => x"6EBF",
    -- 121 => x"36C0",
    -- 122 => x"680D",
    -- 123 => x"DE00",
    -- 124 => x"0800",
    -- 125 => x"EF40",
    -- 126 => x"4F03",
    -- 127 => x"0800",
    -- 128 => x"1031",
    -- 129 => x"0800",
    -- 130 => x"6EBF",
    -- 131 => x"36C0",
    -- 132 => x"9E20",
    -- 133 => x"6EFF",
    -- 134 => x"E9CC",
    -- 135 => x"0800",
    -- 136 => x"6852",
    -- 137 => x"E82A",
    -- 138 => x"6032",
    -- 139 => x"0800",
    -- 140 => x"6844",
    -- 141 => x"E82A",
    -- 142 => x"604D",
    -- 143 => x"0800",
    -- 144 => x"6841",
    -- 145 => x"E82A",
    -- 146 => x"600E",
    -- 147 => x"0800",
    -- 148 => x"6855",
    -- 149 => x"E82A",
    -- 150 => x"6007",
    -- 151 => x"0800",
    -- 152 => x"6847",
    -- 153 => x"E82A",
    -- 154 => x"6009",
    -- 155 => x"0800",
    -- 156 => x"17E0",
    -- 157 => x"0800",
    -- 158 => x"0800",
    -- 159 => x"10C0",
    -- 160 => x"0800",
    -- 161 => x"0800",
    -- 162 => x"1082",
    -- 163 => x"0800",
    -- 164 => x"0800",
    -- 165 => x"1103",
    -- 166 => x"0800",
    -- 167 => x"0800",
    -- 168 => x"6EBF",
    -- 169 => x"36C0",
    -- 170 => x"4E01",
    -- 171 => x"9E00",
    -- 172 => x"6E01",
    -- 173 => x"E8CC",
    -- 174 => x"20F8",
    -- 175 => x"0800",
    -- 176 => x"EF00",
    -- 177 => x"0800",
    -- 178 => x"0800",
    -- 179 => x"6EBF",
    -- 180 => x"36C0",
    -- 181 => x"4E01",
    -- 182 => x"9E00",
    -- 183 => x"6E02",
    -- 184 => x"E8CC",
    -- 185 => x"20F8",
    -- 186 => x"0800",
    -- 187 => x"EF00",
    -- 188 => x"0800",
    -- 189 => x"6906",
    -- 190 => x"6A06",
    -- 191 => x"68BF",
    -- 192 => x"3000",
    -- 193 => x"4810",
    -- 194 => x"E22F",
    -- 195 => x"E061",
    -- 196 => x"9860",
    -- 197 => x"EF40",
    -- 198 => x"4F03",
    -- 199 => x"0800",
    -- 200 => x"17DE",
    -- 201 => x"0800",
    -- 202 => x"6EBF",
    -- 203 => x"36C0",
    -- 204 => x"DE60",
    -- 205 => x"3363",
    -- 206 => x"EF40",
    -- 207 => x"4F03",
    -- 208 => x"0800",
    -- 209 => x"17D5",
    -- 210 => x"0800",
    -- 211 => x"6EBF",
    -- 212 => x"36C0",
    -- 213 => x"DE60",
    -- 214 => x"49FF",
    -- 215 => x"0800",
    -- 216 => x"29E6",
    -- 217 => x"0800",
    -- 218 => x"17A2",
    -- 219 => x"0800",
    -- 220 => x"EF40",
    -- 221 => x"4F03",
    -- 222 => x"0800",
    -- 223 => x"17D2",
    -- 224 => x"0800",
    -- 225 => x"6EBF",
    -- 226 => x"36C0",
    -- 227 => x"9EA0",
    -- 228 => x"6EFF",
    -- 229 => x"EDCC",
    -- 230 => x"0800",
    -- 231 => x"EF40",
    -- 232 => x"4F03",
    -- 233 => x"0800",
    -- 234 => x"17C7",
    -- 235 => x"0800",
    -- 236 => x"6EBF",
    -- 237 => x"36C0",
    -- 238 => x"9E20",
    -- 239 => x"6EFF",
    -- 240 => x"E9CC",
    -- 241 => x"0800",
    -- 242 => x"3120",
    -- 243 => x"E9AD",
    -- 244 => x"EF40",
    -- 245 => x"4F03",
    -- 246 => x"0800",
    -- 247 => x"17BA",
    -- 248 => x"0800",
    -- 249 => x"6EBF",
    -- 250 => x"36C0",
    -- 251 => x"9EA0",
    -- 252 => x"6EFF",
    -- 253 => x"EDCC",
    -- 254 => x"0800",
    -- 255 => x"EF40",
    -- 256 => x"4F03",
    -- 257 => x"0800",
    -- 258 => x"17AF",
    -- 259 => x"0800",
    -- 260 => x"6EBF",
    -- 261 => x"36C0",
    -- 262 => x"9E40",
    -- 263 => x"6EFF",
    -- 264 => x"EACC",
    -- 265 => x"0800",
    -- 266 => x"3240",
    -- 267 => x"EAAD",
    -- 268 => x"9960",
    -- 269 => x"EF40",
    -- 270 => x"4F03",
    -- 271 => x"0800",
    -- 272 => x"1796",
    -- 273 => x"0800",
    -- 274 => x"6EBF",
    -- 275 => x"36C0",
    -- 276 => x"DE60",
    -- 277 => x"3363",
    -- 278 => x"EF40",
    -- 279 => x"4F03",
    -- 280 => x"0800",
    -- 281 => x"178D",
    -- 282 => x"0800",
    -- 283 => x"6EBF",
    -- 284 => x"36C0",
    -- 285 => x"DE60",
    -- 286 => x"4901",
    -- 287 => x"4AFF",
    -- 288 => x"0800",
    -- 289 => x"2AEA",
    -- 290 => x"0800",
    -- 291 => x"1759",
    -- 292 => x"0800",
    -- 293 => x"EF40",
    -- 294 => x"4F03",
    -- 295 => x"0800",
    -- 296 => x"1789",
    -- 297 => x"0800",
    -- 298 => x"6EBF",
    -- 299 => x"36C0",
    -- 300 => x"9EA0",
    -- 301 => x"6EFF",
    -- 302 => x"EDCC",
    -- 303 => x"0800",
    -- 304 => x"EF40",
    -- 305 => x"4F03",
    -- 306 => x"0800",
    -- 307 => x"177E",
    -- 308 => x"0800",
    -- 309 => x"6EBF",
    -- 310 => x"36C0",
    -- 311 => x"9E20",
    -- 312 => x"6EFF",
    -- 313 => x"E9CC",
    -- 314 => x"0800",
    -- 315 => x"3120",
    -- 316 => x"E9AD",
    -- 317 => x"6800",
    -- 318 => x"E82A",
    -- 319 => x"601D",
    -- 320 => x"0800",
    -- 321 => x"EF40",
    -- 322 => x"4F03",
    -- 323 => x"0800",
    -- 324 => x"176D",
    -- 325 => x"0800",
    -- 326 => x"6EBF",
    -- 327 => x"36C0",
    -- 328 => x"9EA0",
    -- 329 => x"6EFF",
    -- 330 => x"EDCC",
    -- 331 => x"0800",
    -- 332 => x"EF40",
    -- 333 => x"4F03",
    -- 334 => x"0800",
    -- 335 => x"1762",
    -- 336 => x"0800",
    -- 337 => x"6EBF",
    -- 338 => x"36C0",
    -- 339 => x"9E40",
    -- 340 => x"6EFF",
    -- 341 => x"EACC",
    -- 342 => x"0800",
    -- 343 => x"3240",
    -- 344 => x"EAAD",
    -- 345 => x"D940",
    -- 346 => x"0800",
    -- 347 => x"17C9",
    -- 348 => x"0800",
    -- 349 => x"0800",
    -- 350 => x"171E",
    -- 351 => x"0800",
    -- 352 => x"EF40",
    -- 353 => x"4F03",
    -- 354 => x"0800",
    -- 355 => x"174E",
    -- 356 => x"0800",
    -- 357 => x"6EBF",
    -- 358 => x"36C0",
    -- 359 => x"9EA0",
    -- 360 => x"6EFF",
    -- 361 => x"EDCC",
    -- 362 => x"0800",
    -- 363 => x"EF40",
    -- 364 => x"4F03",
    -- 365 => x"0800",
    -- 366 => x"1743",
    -- 367 => x"0800",
    -- 368 => x"6EBF",
    -- 369 => x"36C0",
    -- 370 => x"9E20",
    -- 371 => x"6EFF",
    -- 372 => x"E9CC",
    -- 373 => x"0800",
    -- 374 => x"3120",
    -- 375 => x"E9AD",
    -- 376 => x"EF40",
    -- 377 => x"4F03",
    -- 378 => x"0800",
    -- 379 => x"1736",
    -- 380 => x"0800",
    -- 381 => x"6EBF",
    -- 382 => x"36C0",
    -- 383 => x"9EA0",
    -- 384 => x"6EFF",
    -- 385 => x"EDCC",
    -- 386 => x"0800",
    -- 387 => x"EF40",
    -- 388 => x"4F03",
    -- 389 => x"0800",
    -- 390 => x"172B",
    -- 391 => x"0800",
    -- 392 => x"6EBF",
    -- 393 => x"36C0",
    -- 394 => x"9E40",
    -- 395 => x"6EFF",
    -- 396 => x"EACC",
    -- 397 => x"0800",
    -- 398 => x"3240",
    -- 399 => x"EAAD",
    -- 400 => x"9960",
    -- 401 => x"EF40",
    -- 402 => x"4F03",
    -- 403 => x"0800",
    -- 404 => x"1712",
    -- 405 => x"0800",
    -- 406 => x"6EBF",
    -- 407 => x"36C0",
    -- 408 => x"DE60",
    -- 409 => x"3363",
    -- 410 => x"EF40",
    -- 411 => x"4F03",
    -- 412 => x"0800",
    -- 413 => x"1709",
    -- 414 => x"0800",
    -- 415 => x"6EBF",
    -- 416 => x"36C0",
    -- 417 => x"DE60",
    -- 418 => x"4901",
    -- 419 => x"4AFF",
    -- 420 => x"0800",
    -- 421 => x"2AEA",
    -- 422 => x"0800",
    -- 423 => x"16D5",
    -- 424 => x"0800",
    -- 425 => x"EF40",
    -- 426 => x"4F03",
    -- 427 => x"0800",
    -- 428 => x"1705",
    -- 429 => x"0800",
    -- 430 => x"6EBF",
    -- 431 => x"36C0",
    -- 432 => x"9EA0",
    -- 433 => x"6EFF",
    -- 434 => x"EDCC",
    -- 435 => x"0800",
    -- 436 => x"EF40",
    -- 437 => x"4F03",
    -- 438 => x"0800",
    -- 439 => x"16FA",
    -- 440 => x"0800",
    -- 441 => x"6EBF",
    -- 442 => x"36C0",
    -- 443 => x"9E40",
    -- 444 => x"6EFF",
    -- 445 => x"EACC",
    -- 446 => x"0800",
    -- 447 => x"3240",
    -- 448 => x"EAAD",
    -- 449 => x"42C0",
    -- 450 => x"6FBF",
    -- 451 => x"37E0",
    -- 452 => x"4F10",
    -- 453 => x"9FA5",
    -- 454 => x"63FF",
    -- 455 => x"D500",
    -- 456 => x"F500",
    -- 457 => x"6980",
    -- 458 => x"3120",
    -- 459 => x"ED2D",
    -- 460 => x"9F00",
    -- 461 => x"9F21",
    -- 462 => x"9F42",
    -- 463 => x"9F63",
    -- 464 => x"9F84",
    -- 465 => x"EF40",
    -- 466 => x"4F04",
    -- 467 => x"F501",
    -- 468 => x"EE00",
    -- 469 => x"9500",
    -- 470 => x"0800",
    -- 471 => x"0800",
    -- 472 => x"6301",
    -- 473 => x"6FBF",
    -- 474 => x"37E0",
    -- 475 => x"4F10",
    -- 476 => x"DF00",
    -- 477 => x"DF21",
    -- 478 => x"DF42",
    -- 479 => x"DF63",
    -- 480 => x"DF84",
    -- 481 => x"DFA5",
    -- 482 => x"F000",
    -- 483 => x"697F",
    -- 484 => x"3120",
    -- 485 => x"6AFF",
    -- 486 => x"E94D",
    -- 487 => x"E82C",
    -- 488 => x"F001",
    -- 489 => x"6907",
    -- 490 => x"EF40",
    -- 491 => x"4F03",
    -- 492 => x"0800",
    -- 493 => x"16B9",
    -- 494 => x"0800",
    -- 495 => x"6EBF",
    -- 496 => x"36C0",
    -- 497 => x"DE20",
    -- 498 => x"168A",
    -- 499 => x"0800",
    0 => x"0800",
    1 => x"6901",
    2 => x"6A01",
    3 => x"6B85",
    4 => x"3360",
    5 => x"6C05",
    6 => x"DB20",
    7 => x"DB41",
    8 => x"E145",
    9 => x"E149",
    10 => x"4B02",
    11 => x"4CFF",
    12 => x"2CF9",
    13 => x"0800",
    14 => x"EF00",
    15 => x"0800",

    
    others => x"0800");
    
begin

process(addr_i, ram1_data_io, ram2_data_io,
        ram2_r_en_i, ram2_w_en_i,
        com_r_en_i, com_w_en_i)
begin

if(addr_i /= x"BF00" and addr_i /= x"BF01") then
    if(ram2_w_en_i = WRITE_EN) then
        my_ram(IEEE.STD_LOGIC_UNSIGNED.CONV_INTEGER("00" & addr_i)) <= ram2_data_io;
    elsif(ram2_r_en_i = READ_EN) then
        ram2_data_io <= my_ram(IEEE.STD_LOGIC_UNSIGNED.CONV_INTEGER("00" & addr_i));
    else
        ram2_data_io <= ZZZZ_16;
    end if;
elsif(addr_i = x"BF00") then
    if(com_w_en_i = WRITE_EN) then
        my_ram(IEEE.STD_LOGIC_UNSIGNED.CONV_INTEGER("00" & addr_i)) <= x"00" & ram1_data_io(7 downto 0);
    elsif(com_r_en_i = READ_EN) then
        ram1_data_io <= my_ram(IEEE.STD_LOGIC_UNSIGNED.CONV_INTEGER("00" & addr_i));
    else
        ram1_data_io <= ZZZZ_16;
    end if;
end if;

end process;

end Behavioral;


"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const image_1 = require("../nouns-sdk/image");
const node_libpng_1 = require("node-libpng");
const fs_1 = require("fs");
const path_1 = __importDefault(require("path"));
const DESTINATION = path_1.default.join(__dirname, '../../../../logic/data/image-data.json');
const encode = () => __awaiter(void 0, void 0, void 0, function* () {
    const encoder = new image_1.PNGCollectionEncoder();
    const partfolders = ['1-bodies', '2-accessories', '3-heads', '4-glasses'];
    for (const folder of partfolders) {
        const folderpath = path_1.default.join(__dirname, '../../../../logic/images', folder);
        const files = yield fs_1.promises.readdir(folderpath);
        for (const file of files) {
            const image = yield (0, node_libpng_1.readPngFile)(path_1.default.join(folderpath, file));
            encoder.encodeImage(file.replace(/\.png$/, ''), image, folder.replace(/^\d-/, ''));
        }
    }
    yield fs_1.promises.writeFile(DESTINATION, JSON.stringify(Object.assign({ bgcolors: ['d5d7e1', 'e1d7d5'] }, encoder.data), null, 2));
});
encode();
//# sourceMappingURL=encode.js.map
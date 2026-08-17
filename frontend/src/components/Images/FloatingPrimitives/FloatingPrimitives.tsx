import { useLayoutEffect, useState, type CSSProperties } from 'react'

import './FloatingPrimitives.css'

type PrimitiveKind = 'img' | 'sphere' | 'ring' | 'cube'

type PrimitivePattern = {
    kind: PrimitiveKind
    src?: string
    offset: string
    size: number
    rotate?: number
    blur?: number
    opacity?: number
    delay: string
    duration: string
    amplitude: string
}

type PlacedPrimitive = PrimitivePattern & {
    side: 'left' | 'right'
    top: number
}

const STEP = 240

const leftPattern: PrimitivePattern[] = [
    { kind: 'img', src: '/assets/Helix.png', offset: '4px', size: 248, rotate: -22, delay: '-1.2s', duration: '7.5s', amplitude: '-28px' },
    { kind: 'sphere', offset: '168px', size: 42, delay: '-3.4s', duration: '5.8s', amplitude: '-16px' },
    { kind: 'img', src: '/assets/Cube1.png', offset: '28px', size: 138, rotate: 16, delay: '-0.6s', duration: '6.8s', amplitude: '-20px' },
    { kind: 'ring', offset: '148px', size: 52, delay: '-4.1s', duration: '6.2s', amplitude: '-14px' },
    { kind: 'img', src: '/assets/Thorus1.png', offset: '0px', size: 220, rotate: -12, blur: 1.2, opacity: 0.78, delay: '-2.2s', duration: '8.4s', amplitude: '-26px' },
    { kind: 'img', src: '/assets/Pill1.png', offset: '88px', size: 124, rotate: 42, delay: '-0.9s', duration: '6.5s', amplitude: '-18px' },
    { kind: 'img', src: '/assets/Helix.png', offset: '40px', size: 210, rotate: 38, delay: '-5.5s', duration: '7.1s', amplitude: '-24px' },
    { kind: 'sphere', offset: '16px', size: 36, delay: '-1.8s', duration: '5.4s', amplitude: '-12px' },
    { kind: 'img', src: '/assets/ThorusKnot.png', offset: '8px', size: 188, rotate: 18, delay: '-3.8s', duration: '8s', amplitude: '-22px' },
    { kind: 'img', src: '/assets/Cube1.png', offset: '72px', size: 118, rotate: -24, delay: '-2.8s', duration: '6.4s', amplitude: '-16px' },
    { kind: 'img', src: '/assets/Thorus2.png', offset: '12px', size: 176, rotate: 14, delay: '-4.4s', duration: '7.8s', amplitude: '-20px' },
    { kind: 'ring', offset: '120px', size: 48, delay: '-1.1s', duration: '5.9s', amplitude: '-14px' },
    { kind: 'img', src: '/assets/Helix.png', offset: '32px', size: 228, rotate: -30, delay: '-6.2s', duration: '8.1s', amplitude: '-26px' },
    { kind: 'img', src: '/assets/Pill1.png', offset: '96px', size: 132, rotate: 48, blur: 1.5, opacity: 0.7, delay: '-0.4s', duration: '6.6s', amplitude: '-18px' },
    { kind: 'img', src: '/assets/ThorusKnot.png', offset: '6px', size: 196, rotate: 10, delay: '-3.2s', duration: '7.7s', amplitude: '-22px' },
    { kind: 'img', src: '/assets/Sphere.png', offset: '64px', size: 72, delay: '-5s', duration: '5.6s', amplitude: '-14px' },
]

const rightPattern: PrimitivePattern[] = [
    { kind: 'img', src: '/assets/Helix.png', offset: '8px', size: 236, rotate: 24, delay: '-2.6s', duration: '7.8s', amplitude: '-26px' },
    { kind: 'sphere', offset: '156px', size: 40, delay: '-0.8s', duration: '5.6s', amplitude: '-14px' },
    { kind: 'img', src: '/assets/Pill1.png', offset: '28px', size: 148, rotate: -38, delay: '-4.6s', duration: '6.9s', amplitude: '-22px' },
    { kind: 'cube', offset: '164px', size: 36, rotate: 22, delay: '-1.5s', duration: '5.2s', amplitude: '-12px' },
    { kind: 'img', src: '/assets/Thorus2.png', offset: '4px', size: 168, rotate: 28, delay: '-3.1s', duration: '7.4s', amplitude: '-20px' },
    { kind: 'img', src: '/assets/Cube1.png', offset: '76px', size: 128, rotate: -18, delay: '-5.2s', duration: '8.2s', amplitude: '-18px' },
    { kind: 'img', src: '/assets/Helix.png', offset: '20px', size: 220, rotate: -16, delay: '-2.4s', duration: '7.2s', amplitude: '-24px' },
    { kind: 'ring', offset: '140px', size: 50, delay: '-2s', duration: '6s', amplitude: '-14px' },
    { kind: 'img', src: '/assets/Thorus1.png', offset: '0px', size: 212, rotate: 20, blur: 1.2, opacity: 0.76, delay: '-4.9s', duration: '8.3s', amplitude: '-26px' },
    { kind: 'img', src: '/assets/Sphere.png', offset: '92px', size: 68, delay: '-1.6s', duration: '5.5s', amplitude: '-14px' },
    { kind: 'img', src: '/assets/ThorusKnot.png', offset: '16px', size: 192, rotate: -14, delay: '-4.8s', duration: '7.6s', amplitude: '-22px' },
    { kind: 'img', src: '/assets/Pill1.png', offset: '68px', size: 140, rotate: 32, delay: '-0.7s', duration: '6.7s', amplitude: '-18px' },
    { kind: 'img', src: '/assets/Cube1.png', offset: '44px', size: 122, rotate: 12, blur: 1.8, opacity: 0.65, delay: '-3.6s', duration: '7s', amplitude: '-16px' },
    { kind: 'img', src: '/assets/Helix.png', offset: '8px', size: 232, rotate: -28, delay: '-1s', duration: '8.6s', amplitude: '-28px' },
    { kind: 'ring', offset: '128px', size: 46, delay: '-5.8s', duration: '5.7s', amplitude: '-12px' },
    { kind: 'img', src: '/assets/ThorusKnot.png', offset: '24px', size: 204, rotate: 8, delay: '-2.9s', duration: '7.9s', amplitude: '-24px' },
]

function placeColumn(
    pattern: PrimitivePattern[],
    side: 'left' | 'right',
    height: number,
    start: number,
): PlacedPrimitive[] {
    const items: PlacedPrimitive[] = []
    let index = 0

    for (let top = start; top < height; top += STEP) {
        items.push({
            ...pattern[index % pattern.length],
            side,
            top,
        })
        index += 1
    }

    return items
}

function useRootHeight() {
    const [height, setHeight] = useState(() => (
        typeof window === 'undefined' ? 0 : window.innerHeight
    ))

    useLayoutEffect(() => {
        const root = document.getElementById('root')
        if (!root) {
            return
        }

        const update = () => setHeight(root.offsetHeight)
        update()

        const observer = new ResizeObserver(update)
        observer.observe(root)
        return () => observer.disconnect()
    }, [])

    return height
}

export function FloatingPrimitives() {
    const height = useRootHeight()
    const primitives = [
        ...placeColumn(leftPattern, 'left', height, 32),
        ...placeColumn(rightPattern, 'right', height, 80),
    ]

    return (
        <div className="floating-primitives" aria-hidden="true">
            {primitives.map((primitive, index) => (
                <div
                    key={`${primitive.kind}-${primitive.side}-${index}`}
                    className={`floating-primitive floating-primitive--${primitive.side}`}
                    style={{
                        top: `${primitive.top}px`,
                        [primitive.side]: primitive.offset,
                        '--float-amp': primitive.amplitude,
                        animationDelay: primitive.delay,
                        animationDuration: primitive.duration,
                    } as CSSProperties}
                >
                    {primitive.kind === 'img' ? (
                        <img
                            src={primitive.src}
                            alt=""
                            className="floating-primitive-shape"
                            style={{
                                width: primitive.size,
                                transform: primitive.rotate ? `rotate(${primitive.rotate}deg)` : undefined,
                                filter: primitive.blur ? `blur(${primitive.blur}px)` : undefined,
                                opacity: primitive.opacity,
                            }}
                        />
                    ) : (
                        <span
                            className={`floating-accent floating-accent--${primitive.kind}`}
                            style={{
                                width: primitive.size,
                                height: primitive.size,
                                transform: primitive.rotate ? `rotate(${primitive.rotate}deg)` : undefined,
                            }}
                        />
                    )}
                </div>
            ))}
        </div>
    )
}
